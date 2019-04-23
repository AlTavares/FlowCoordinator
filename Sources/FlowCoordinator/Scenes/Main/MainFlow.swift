//
//  MainFlow.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

final class MainFlow: FlowCoordinator {
    var root: UIViewController {
        return navigationController
    }

    let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController = navigationController
    }

    func start() -> Completable {
        return show(makeMenuViewController())
    }
}

private extension MainFlow {
    enum MenuOption: String, CustomStringConvertible, CaseIterable {
        case verticalRegistration
        case horizontalRegistration

        var description: String {
            switch self {
            case .verticalRegistration:
                return "Vertical Flow"
            case .horizontalRegistration:
                return "Horizontal Flow"
            }
        }
    }

    func makeMenuViewController() -> UIViewController {
        let viewModel = SelectionViewModel<MenuOption>()
        viewModel.title = "Flows"
        viewModel.options = MenuOption.allCases
        let viewController = SelectionViewController<MenuOption>(viewModel: viewModel)

        viewController.events.onNext { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .didSelectElement(let element, _):
                let flow: RegistrationFlow
                switch element {
                case .verticalRegistration:
                    flow = RegistrationFlow()
                case .horizontalRegistration:
                    flow = RegistrationFlow(navigationController: self.navigationController)
                }
                flow.events.onNext { event in
                    switch event {
                    case .didFinishRegistration(let name, let email, let pet, let registrationFlow):
                        let message = "Name: \(name)\nEmail: \(email)\nPet: \(pet)"
                        let alert = UIAlertController(title: "Registration", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak alert] _ in
                            alert?.dismiss(animated: true)
                        })

                        self.navigationController.popToRootViewController(animated: true)
                        self.finishShowing(registrationFlow)
                            .andThen(self.present(alert))
                            .subscribe()
                            .ignoreDisposable()
                    }
                }
                self.show(flow)
            }
        }
        return viewController
    }
}
