//
//  EmailViewController.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 22/04/19.
//

import RxBiBinding
import RxSwift
import UIKit

class EmailViewController: ViewController {
    private var disposeBag = DisposeBag()
    var viewModel: RegistrationViewModel!

    var contentView: InputView {
        return view as! InputView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.button.setTitle("OK", for: .normal)
        (contentView.textField.rx.text <-> viewModel.email).disposed(by: disposeBag)

        viewModel.isEmailValid
            .bind(to: contentView.button.rx.isEnabled)
            .disposed(by: disposeBag)

        contentView.button.rx
            .tap
            .withUnretained(self)
            .subscribeNext { $0.performSegue(withIdentifier: "pushPet", sender: nil) }
            .disposed(by: disposeBag)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let petViewController = segue.destination as! PetViewController
        petViewController.viewModel = viewModel
    }

}
