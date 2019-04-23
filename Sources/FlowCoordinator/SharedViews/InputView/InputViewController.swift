//
//  InputViewController.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import RxBiBinding
import RxCocoa
import RxSwift
import UIKit

class InputViewModel {
    var title: String?
    var buttonTitle: String?
    var inputValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)

    var isValid: Observable<Bool>?
}

class InputViewController: ViewController {
    enum Event: EventType {
        case didTapButton(viewController: InputViewController)
    }

    let events = EventEmitter<Event>()

    private var disposeBag = DisposeBag()
    let contentView = InputView()
    let viewModel: InputViewModel

    init(viewModel: InputViewModel) {
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
        title = viewModel.title
        contentView.button.setTitle(viewModel.buttonTitle, for: .normal)
        (contentView.textField.rx.text <-> viewModel.inputValue).disposed(by: disposeBag)

        viewModel.isValid?
            .bind(to: contentView.button.rx.isEnabled)
            .disposed(by: disposeBag)

        contentView.button.rx
            .tap
            .withUnretained(self)
            .map(Event.didTapButton)
            .bind(to: events.emitter)
            .disposed(by: disposeBag)
    }
}
