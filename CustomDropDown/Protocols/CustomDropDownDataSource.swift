//
//  CustomDropDownDataSource.swift
//  CustomDropDown
//
//  Created by Jacqueline Alves on 22/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public protocol CustomDropDownDataSource: class {
    func overrideDropDownView(identifier: Int) -> UIView?
    func config(identifier: Int) -> DropDownConfig
    func numberOfSections(in tableView: UITableView, identifier: Int) -> Int?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int, identifier: Int) -> CGFloat
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int, identifier: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath, identifier: Int) -> CGFloat
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int, identifier: Int) -> Int?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, identifier: Int) -> UITableViewCell?
}

public extension CustomDropDownDataSource where Self: NSObject {
    func overrideDropDownView(identifier: Int) -> UIView? {
        return nil
    }

    func config(identifier: Int) -> DropDownConfig {
        return DropDownConfig()
    }
    
    func numberOfSections(in tableView: UITableView, identifier: Int) -> Int? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int, identifier: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int, identifier: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath, identifier: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int, identifier: Int) -> Int? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, identifier: Int) -> UITableViewCell? {
        return nil
    }
}
