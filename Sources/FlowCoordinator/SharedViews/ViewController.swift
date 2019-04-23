//
//  ViewController.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 18/04/19.
//  Copyright © 2019 Alexandre Mantovani Tavares. All rights reserved.
//

import UIKit

open class ViewController: UIViewController {
    open override var description: String {
        return typeName
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        Logger.released(self)
    }
}

public extension UIViewController {
    class var typeName: String {
        return String(describing: self)
    }

    var typeName: String {
        return type(of: self).typeName
    }
}
