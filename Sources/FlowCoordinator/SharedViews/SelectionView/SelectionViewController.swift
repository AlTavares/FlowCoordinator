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

class SelectionViewModel<Element: CustomStringConvertible> {
    var title: String?
    var selectedValue: BehaviorRelay<Element?> = BehaviorRelay(value: nil)

    var options: [Element] = []
}

class SelectionViewController<Element: CustomStringConvertible>: ViewController {
    private var disposeBag = DisposeBag()
    enum Event: EventType {
        case didSelectElement(element: Element, viewController: SelectionViewController)
    }

    let events = EventEmitter<Event>()

    let contentView = SelectionView()
    let viewModel: SelectionViewModel<Element>

    init(viewModel: SelectionViewModel<Element>) {
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

        viewModel.options.forEach { [viewModel] element in
            contentView.addButton(title: element.description)
                .rx
                .tap
                .asObservable()
                .withUnretained(self)
                .map{ viewController in
                    viewModel.selectedValue.accept(element)
                    return Event.didSelectElement(element: element, viewController: viewController)
                }
                .bind(to: events.emitter)
                .disposed(by: disposeBag)
        }
    }
}
