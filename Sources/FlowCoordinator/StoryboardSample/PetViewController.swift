//
//  EmailViewController.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 22/04/19.
//

import RxBiBinding
import RxSwift
import UIKit

class PetViewController: ViewController {
    private var disposeBag = DisposeBag()
    var viewModel: RegistrationViewModel!

    var contentView: SelectionView {
        return view as! SelectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Pet.allCases.forEach { element in
            contentView.addButton(title: element.description)
                .rx
                .tap
                .asObservable()
                .withUnretained(self)
                .subscribeNext {
                    $0.viewModel.favoritePet.accept(element)
                    let detailsViewController = DetailsViewController(viewModel: $0.viewModel)
                    $0.navigationController?.pushViewController(detailsViewController, animated: true)
                }
                .disposed(by: disposeBag)
        }
    }
}
