//
//  RegistrationFlow.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

final class RegistrationFlow: FlowCoordinator {
    enum Event: EventType {
        case didFinishRegistration(name: String, email: String, pet: String, flow: RegistrationFlow)
    }

    let events = EventEmitter<Event>()
    let viewModel = RegistrationViewModel()
    var root: UIViewController {
        return navigationController
    }

    let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController = navigationController
    }

    func start() -> Completable {
        let isNavigationControllerEmpty = navigationController.children.isEmpty
        let firstViewController = makeNameViewController()

        firstViewController.rx.didPopFromParent
            .withUnretained(self)
            .bind(to: didFinish)
            .disposed(by: disposeBag)

        if isNavigationControllerEmpty {
            let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)
            firstViewController.navigationItem.leftBarButtonItem = cancelButton
            cancelButton.rx.tap.withUnretained(self)
                .bind(to: didFinish)
                .disposed(by: disposeBag)
        }

        navigationController.pushViewController(firstViewController, animated: !isNavigationControllerEmpty)
        return .empty()
    }
}

private extension RegistrationFlow {
    func makeNameViewController(editing: Bool = false) -> UIViewController {
        let viewModel = InputViewModel()
        viewModel.title = "Name"
        viewModel.buttonTitle = "OK"
        viewModel.inputValue = self.viewModel.name
        viewModel.isValid = self.viewModel.isNameValid
        let viewController = InputViewController(viewModel: viewModel)

        viewController.events.onNext { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .didTapButton(let viewController):
                switch editing {
                case true:
                    self.finishShowing(viewController)
                case false:
                    self.show(self.makeEmailViewController())
                }
            }
        }
        return viewController
    }

    func makeEmailViewController(editing: Bool = false) -> UIViewController {
        let viewModel = InputViewModel()
        viewModel.title = "Email"
        viewModel.buttonTitle = "OK"
        viewModel.inputValue = self.viewModel.email
        viewModel.isValid = self.viewModel.isEmailValid
        let viewController = InputViewController(viewModel: viewModel)

        viewController.events.onNext { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .didTapButton(let viewController):
                switch editing {
                case true:
                    self.finishShowing(viewController)
                case false:
                    self.show(self.makeSelectPetViewController())
                }
            }
        }

        return viewController
    }

    func makeSelectPetViewController(editing: Bool = false) -> UIViewController {
        let viewModel = SelectionViewModel<Pet>()
        viewModel.title = "Favorite pet"
        viewModel.selectedValue = self.viewModel.favoritePet
        viewModel.options = Pet.allCases
        let viewController = SelectionViewController<Pet>(viewModel: viewModel)

        viewController.events.onNext { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .didSelectElement(let element, let viewController):
                Logger.debug("Selected \(element)")
                switch editing {
                case true:
                    self.finishShowing(viewController)
                case false:
                    self.show(self.makeDetailsViewController())
                }
            }
        }

        return viewController
    }

    func makeDetailsViewController() -> UIViewController {
        let viewController = DetailsViewController(viewModel: viewModel)
        viewController.events.onNext { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .didSelectName:
                self.show(self.makeNameViewController(editing: true))
            case .didSelectEmail:
                self.show(self.makeEmailViewController(editing: true))
            case .didSelectPet:
                self.show(self.makeSelectPetViewController(editing: true))
            case .didTapButton:
                if let name = self.viewModel.name.value,
                    let email = self.viewModel.email.value,
                    let pet = self.viewModel.favoritePet.value {
                    let event = Event.didFinishRegistration(name: name,
                                                            email: email,
                                                            pet: pet.description,
                                                            flow: self)
                    self.events.emit(event)
                }
            }
        }
        return viewController
    }
}
