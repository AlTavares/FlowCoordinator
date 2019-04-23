//
//  UIView+Separator.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 20/04/19.
//

import Foundation
import TinyConstraints
import UIKit

extension UIView {
    func addSeparator(height: CGFloat = 0.5, color: UIColor?, leading: CGFloat = 0, trailing: CGFloat = 0) {
        let separatorView = UIView()
        addSubview(separatorView)
        separatorView.backgroundColor = color
        separatorView.edgesToSuperview(excluding: .top, insets: .left(leading) + .right(trailing))
        separatorView.height(height)
    }
}

extension UIView {
    func findSubview(withDescription name: String) -> UIView? {
        return findSubview(withDescription: name, in: self)
    }

    func findSubview(withDescription name: String, in parentView: UIView) -> UIView? {
        for subView in parentView.subviews {
            if subView.self.description.contains(name) {
                return subView
            } else {
                if let reorderView = self.findSubview(withDescription: name, in: subView) {
                    return reorderView
                }
            }
        }
        return nil
    }
}
