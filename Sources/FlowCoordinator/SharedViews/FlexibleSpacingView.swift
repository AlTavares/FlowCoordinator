//
//  FlexibleSpacingView.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 20/04/19.
//

import Foundation
import UIKit

class FlexibleSpacingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        render()
    }

    private func render() {
        setHugging(UILayoutPriority(0), for: .vertical)
        setHugging(UILayoutPriority(0), for: .horizontal)
        setCompressionResistance(UILayoutPriority(0), for: .vertical)
        setCompressionResistance(UILayoutPriority(0), for: .horizontal)
    }
}
