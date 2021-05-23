//
//  TabItem.swift
//  CustomTabBar
//
//  Created by administrador on 22/05/21.
//

import UIKit
enum TabItem: String {
    case dashboard = "dashboard"
    case create = "create"
    case profile = "profile"
    
    // Here we define the UIViewController that each Tab Item lead us
    var viewController: UIViewController {
        switch self {
        case .dashboard:
            return RedViewController()
            
        case .create:
            return GreenViewController()
        case .profile:

            return GreenViewController()
        }
    }
    // Here we define the icon of each Tab Item
    var icon: UIImage {
        switch self {
        case .dashboard:
            return UIImage(named: "dashboard") ?? UIImage()
        case .create:
            return UIImage(named: "create") ?? UIImage()
        case .profile:
            return UIImage(named: "profile") ?? UIImage()
        }
    }
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
