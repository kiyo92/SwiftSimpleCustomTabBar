//
//  AppDelegate.swift
//  CustomTabBar
//
//  Created by administrador on 23/05/21.
//

import Foundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = MainTabBarController()
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }

}
