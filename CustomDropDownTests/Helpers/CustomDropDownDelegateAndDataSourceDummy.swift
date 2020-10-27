//
//  CustomDropDownDelegateAndDataSourceDummy.swift
//  CustomDropDownTests
//
//  Created by Jacqueline Alves on 27/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

@testable import CustomDropDown

class CustomDropDownDelegateAndDataSourceDummy: NSObject, CustomDropDownDelegate, CustomDropDownDataSource {
    var config: DropDownConfig?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, displayView: UIView, config: DropDownConfig, data: Any, identifier: Int) {}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any, identifier: Int) {}
    
    func config(identifier: Int) -> DropDownConfig {
        return config ?? DropDownConfig()
    }
}
