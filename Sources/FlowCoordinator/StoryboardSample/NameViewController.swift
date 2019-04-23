//
//  NameViewController.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 22/04/19.
//

import Foundation
import RxBiBinding
import RxSwift
import UIKit

class NameViewController: ViewController {
    private var disposeBag = DisposeBag()
    var contentView: InputView {
        return view as! InputView
    }

    var viewModel: RegistrationViewModel = RegistrationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.button.setTitle("OK", for: .normal)
        (contentView.textField.rx.text <-> viewModel.name).disposed(by: disposeBag)

        viewModel.isNameValid
            .bind(to: contentView.button.rx.isEnabled)
            .disposed(by: disposeBag)

        contentView.button.rx
            .tap
            .withUnretained(self)
            .subscribeNext {
                $0.performSegue(withIdentifier: "pushEmail", sender: nil)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let emailViewController = segue.destination as! EmailViewController
        emailViewController.viewModel = viewModel
    }
}
