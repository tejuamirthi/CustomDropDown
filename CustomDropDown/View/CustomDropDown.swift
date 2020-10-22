//
//  CustomDropDown.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 04/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

class CustomDropDown<T>: UIView {
    
    var tableView: UITableView = UITableView()
    
    init(dropDownView: CustomDropDownView<T>, tag: Int) {
        super.init(frame: .zero)
        self.tag = tag
        tableView.dataSource = dropDownView
        tableView.delegate = dropDownView
        tableView.register(DropDownImageLabelView.self, forCellReuseIdentifier: "DropDownImageLabelView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UILabel")
        tableView.backgroundColor = .lightGray
        self.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
