//
//  ApplicationFlow.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 06/02/19.
//

import Foundation
import RxSwift

final class ApplicationFlow: FlowCoordinator {
    var root: UIViewController {
        return self.initialFlow.root
    }

    lazy var initialFlow: FlowCoordinator = makeMainFlow()

    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
        super.init()
        window.rootViewController = root
        window.makeKeyAndVisible()
    }

    func start() -> Completable {
        return show(self.initialFlow)
    }
}

private extension ApplicationFlow {
    func makeRegistrationFlow() -> FlowCoordinator {
        return RegistrationFlow()
    }

    func makeMainFlow() -> FlowCoordinator {
        return MainFlow()
    }
}
