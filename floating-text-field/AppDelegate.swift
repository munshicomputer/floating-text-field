//
//  AppDelegate.swift
//  floating-text-field
//
//  Created by SHAMIM MUNSHI on 17/4/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        return true
    }
}

