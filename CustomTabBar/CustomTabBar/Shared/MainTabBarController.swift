//
//  MainTabBarController.swift
//  CustomTabBar
//
//  Created by administrador on 22/05/21.
//

import Foundation
import UIKit
class MainTabBarController: UITabBarController {
    var customTabBar: TabNavigationView!
    var tabBarHeight: CGFloat = 55
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        self.tabBar.tintColor = UIColor(white: 1, alpha: 0)
        self.tabBar.barTintColor = UIColor(white: 1, alpha: 0)
        self.tabBar.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    func loadTabBar() {
        let tabItems: [TabItem] = [.dashboard, .create, .profile]
        self.setupCustomTabMenu(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        self.selectedIndex = 0
    }
    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        // hide the tab bar
        tabBar.isHidden = true
        self.customTabBar = TabNavigationView(menuItems: menuItems, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        // Add it to the view
        self.view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight), // Fixed height for nav menu
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        for i in 0 ..< menuItems.count {
            controllers.append(menuItems[i].viewController)
        }
        self.view.layoutIfNeeded()
        completion(controllers)
    }
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
