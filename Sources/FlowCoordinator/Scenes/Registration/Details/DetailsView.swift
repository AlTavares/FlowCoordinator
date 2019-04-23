//
//  DetailsView.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 20/04/19.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

@IBDesignable
class DetailsView: UIView {
    private var disposeBag = DisposeBag()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    let button: UIButton = {
        let button = DefaultButton()
        button.height(60)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        return button
    }()

    private let spacer = FlexibleSpacingView()
    private func render() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.edgesToSuperview(insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), usingSafeArea: true)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(button)
    }

    func addRow(title: String, value: Observable<String?>) -> DetailsCell {
        let cell = DetailsCell()
        cell.titleLabel.text = title
        value.bind(to: cell.button.rx.title()).disposed(by: disposeBag)
        let index = stackView.arrangedSubviews.index(of: spacer) ?? 0
        stackView.insertArrangedSubview(cell, at: index)
        cell.height(80)
        return cell
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

class DetailsCell: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()

    private func render() {
        addSubview(stackView)
        stackView.edgesToSuperview()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
        addSeparator(color: .darkGray)
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
