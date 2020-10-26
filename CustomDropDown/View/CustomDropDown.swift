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
    
    // Making the view's masksToBounds = true to have round corners prevent the shadow to appear. So, it is necessary to
    // use the tableview's cornerRadius instead. This way, the shadow can be applied to the view while the
    // round corners are applied to the tableview.
    var cornerRadius: CGFloat = 0.0 {
        didSet{
            tableView.layer.cornerRadius = cornerRadius
            tableView.layer.masksToBounds = true
        }
    }
    
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
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
