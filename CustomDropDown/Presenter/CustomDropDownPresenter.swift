//
//  CustomDropDownPresenter.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 04/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public protocol CustomDropDownDataSource: class {
    func overrideDropDownView() -> UIView?
    func numberOfSections(in tableView: UITableView) -> Int?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell?
}

public extension CustomDropDownDataSource where Self: NSObject {
    func overrideDropDownView() -> UIView? {
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
}

public protocol CustomDropDownDelegate: class {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

//class DropDownItem: UIView {
//    open var title: String?
//}

public class CustomDropDownPresenter<T>: NSObject {
    var items: [T]
    weak var datasource: CustomDropDownDataSource?
    weak var delegate: CustomDropDownDelegate?
    var dropDown: CustomDropDownView<T>!
    
    // MARK: - Initializer
    public init(items: [T], delegate: CustomDropDownDelegate?) {
        self.items = items
        print(items[0])
        super.init()
        self.delegate = delegate
        self.datasource = delegate as? CustomDropDownDataSource
        dropDown = CustomDropDownView(delegate: self)
    }
    
    public func getDropDownView() -> UIView {
        return dropDown as UIView
    }
    
    func overrideDropDownView() -> UIView? {
        return datasource?.overrideDropDownView()
    }
}

//extension CustomDropDownPresenter: {
//    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var rows = 0
//        switch DropDownSections.init(rawValue: section) {
//        case .categories:
//            rows = categoryList?.categories?.count ?? 0
//        case .none:
//            break
//        }
//        return rows
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        0.0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        let label = UILabel()
//        let name = DropDownSections.init(rawValue: section)
//        label.attributedText = NSAttributedString(string: name?.desc() ?? "", attributes: [
//            NSAttributedString.Key.foregroundColor : UIColor.black
//        ])
//        view.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
//        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
//        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        return view
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        DropDownSections.allCases.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
//    }
//
//    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = UITableViewCell()
//        let label: UILabel = UILabel()
//        label.text = TypesOfSearch.init(rawValue: indexPath.row)?.description
//        if(indexPath.section == 0) {
//            let categoryName: String? = categoryList?.categories?[indexPath.row].categories?.name
//            label.text = categoryName
//            if(indexPath.row == 0) {
//                label.attributedText = NSAttributedString(string: categoryName ?? "Category", attributes: [
//                    NSAttributedString.Key.foregroundColor: UIColor.lightGray
//                ])
//            }
//        }
//        cell.addSubview(label)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10).isActive = true
//        label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10).isActive = true
//        label.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 10).isActive = true
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let category: Categories = categoryList?.categories?[indexPath.row].categories else {
//            return
//        }
//        delegate?.optionSelected(category: category)
//    }
//}
