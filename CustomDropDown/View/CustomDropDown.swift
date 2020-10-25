//
//  CustomDropDown.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 04/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

class CustomDropDown<T>: UIView {
    
    // MARK: - Variables
    
    public var cornerRadius: CGFloat = 0.0 {
        didSet{
            containerView.layer.cornerRadius = cornerRadius
            containerView.layer.masksToBounds = true
        }
    }
    
    private let containerView = UIView()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Life cycle
    
    init(dropDownView: CustomDropDownView<T>, tag: Int) {
        super.init(frame: .zero)
        self.tag = tag
        
        setupView()
        setupTableView(with: dropDownView)
        registerCells()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table View
    
    private func setupTableView(with dropDownView: CustomDropDownView<T>) {
        tableView.dataSource = dropDownView
        tableView.delegate = dropDownView
    }
    
    private func registerCells() {
        tableView.register(DropDownImageLabelView.self, forCellReuseIdentifier: DropDownImageLabelView.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UILabel")
    }
}

// MARK: - ViewCode

extension CustomDropDown: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(tableView)
    }
    
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
}
