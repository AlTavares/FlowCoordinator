//
//  AppDelegate.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 18/04/19.
//  Copyright © 2019 Alexandre Mantovani Tavares. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationFlow: FlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        EventPlugins.register(plugin: EventLogger)

        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationFlow = ApplicationFlow(window: window)
        self.window = window
        self.applicationFlow = applicationFlow
        applicationFlow.start().subscribeCompleted {
            Logger.debug("Application Flow started")
        }.ignoreDisposable()
        return true
    }


}

