//
//  SelectionView.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import Foundation
import UIKit

class SelectionView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    private func render() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.edgesToSuperview(insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), usingSafeArea: true)
    }

    func addButton(title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(30)
        button.addSeparator(color: .darkGray)
        stackView.addArrangedSubview(button)
        return button
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
