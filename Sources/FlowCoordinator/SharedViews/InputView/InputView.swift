//
//  InputView.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import Foundation
import TinyConstraints
import UIKit

class InputView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        return stackView
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.height(44)
        return textField
    }()

    let button: UIButton = {
        let button = DefaultButton()
        button.height(60)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        return button
    }()

    private func render() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.edgesToSuperview(insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16) ,usingSafeArea: true)

        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        render()
    }
}
