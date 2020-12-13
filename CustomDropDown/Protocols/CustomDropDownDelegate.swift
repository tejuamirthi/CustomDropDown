//
//  CustomDropDownDelegate.swift
//  CustomDropDown
//
//  Created by Jacqueline Alves on 22/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public protocol CustomDropDownDelegate: class {
    // Use in case of custom Implementation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, displayView: UIView, data: Any?, identifier: Int)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any?, identifier: Int)
}

public extension CustomDropDownDelegate where Self: NSObject {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, displayView: UIView, data: Any?, identifier: Int) {
        
        
        
        
        
        
        
        
    }
}
