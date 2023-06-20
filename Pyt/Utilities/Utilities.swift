//
//  Utilities.swift
//  Pyt
//
//  Created by Mauro de Oliveira  Andre on 13/06/23.
//

import Foundation



final class Utilities{
    
    static let shared = Utilities()
    private init() {}
    
    extension UIApplication {
        class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
            if let navigationController = controller as? UINavigationController {
                return topViewController(controller: navigationController.visibleViewController)
            }
            if let tabController = controller as? UITabBarController {
                if let selected = tabController.selectedViewController {
                    return topViewController(controller: selected)
                }
            }
            if let presented = controller?.presentedViewController {
                return topViewController(controller: presented)
            }
            return controller
        }
    }
}
