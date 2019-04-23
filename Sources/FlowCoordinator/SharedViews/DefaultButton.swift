//
//  UIButton+DisabledState.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import Foundation
import UIKit

class DefaultButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.5
        }
    }
}
