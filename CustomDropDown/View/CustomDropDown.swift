//
//  CustomDropDown.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 04/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public struct ImageLabelData {
    public var title: String?
    public var image: UIImage?
    
    public init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}

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

extension UIView {
    func addAnchors(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, padding: CGFloat = 5, widthConstraint: NSLayoutConstraint? = nil, heightConstraint: NSLayoutConstraint? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding).isActive = true
        }

        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -padding).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: padding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding).isActive = true
        }
        
        if let widthConstraint = widthConstraint {
            widthConstraint.isActive = true
        }
        
        if let heightConstraint = heightConstraint {
            heightConstraint.isActive = true
        }
    }
}
