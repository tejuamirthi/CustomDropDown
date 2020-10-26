//
//  UIWindowExtension.swift
//  CustomDropDown
//
//  Created by Franklin Samboni on 26/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
