//
//  SelectionViewController.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import RxBiBinding
import RxCocoa
import RxSwift
import UIKit

class DetailsViewController: ViewController {
    private var disposeBag = DisposeBag()
    enum Event: EventType {
        case didSelectName(viewController: DetailsViewController)
        case didSelectEmail(viewController: DetailsViewController)
        case didSelectPet(viewController: DetailsViewController)
        case didTapButton(viewController: DetailsViewController)
    }

    let events = EventEmitter<Event>()

    let contentView = DetailsView()
    let viewModel: RegistrationViewModel

    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    public required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        contentView.button.setTitle("OK", for: .normal)
        contentView.button.rx
            .tap
            .withUnretained(self)
            .map(Event.didTapButton)
            .bind(to: events.emitter)
            .disposed(by: disposeBag)

        viewModel.isValid
            .bind(to: contentView.button.rx.isEnabled)
            .disposed(by: disposeBag)

        addObserver(cell: contentView.addRow(title: "Name", value: viewModel.name.asObservable()),
                    toEvent: Event.didSelectName)
        addObserver(cell: contentView.addRow(title: "Email", value: viewModel.email.asObservable()),
                    toEvent: Event.didSelectEmail)
        addObserver(cell: contentView.addRow(title: "Favorite pet", value: viewModel.favoritePet.map { $0?.description }),
                    toEvent: Event.didSelectPet)
    }

    func addObserver(cell: DetailsCell, toEvent: @escaping (DetailsViewController) -> Event) {
        cell.button.rx.tap
            .asObservable()
            .withUnretained(self)
            .map(toEvent)
            .bind(to: events.emitter)
            .disposed(by: disposeBag)
    }
}
