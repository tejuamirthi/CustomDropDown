//
//  MultiSelectViewController.swift
//  Example
//
//  Created by Amirthy Tejeshwar on 09/12/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit
import CustomDropDown

class MultiSelectViewController: UIViewController {

    let items = ["Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let items = [
            MultiSelectData(title: "Go hard", isSelected: false),
            MultiSelectData(title: "Go home", isSelected: true),
            MultiSelectData(title: "Try again", isSelected: true),
            MultiSelectData(title: "Go hard", isSelected: false),
            MultiSelectData(title: "Go home", isSelected: false),
            MultiSelectData(title: "Try again", isSelected: false)
        ]
        
        let ccp = CustomDropDownPresenter(items: items, delegate: self)
        let newView = ccp.getDropDownView()
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newView.backgroundColor = .darkGray
        // Do any additional setup after loading the view.
    }
}

//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let label = UILabel()
//        label.attributedText = NSAttributedString(string: items[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
//        cell.contentView.addSubview(label)
//        cell.contentView.backgroundColor = .gray
//        label.addAnchors(top: cell.contentView.topAnchor, bottom: cell.contentView.bottomAnchor, left: cell.contentView.leftAnchor, right: cell.contentView.rightAnchor, padding: 8, widthConstraint: nil, heightConstraint: label.heightAnchor.constraint(greaterThanOrEqualToConstant: 32))
//        return cell
//    }
//}
extension MultiSelectViewController: CustomDropDownDelegate, CustomDropDownDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any?, identifier: Int) {
        
    }
    func config(identifier: Int) -> DropDownConfig {
        var config = DropDownConfig()
        
        config.dropDownMode = .multiSelect
        config.dropDownCollapsable = false
        var shadowAndCornerConfig = ShadowAndCornerConfig()
        shadowAndCornerConfig.shadowOffset = CGSize(width: 5, height: 5)
        shadowAndCornerConfig.shadowOpacity = 0.8
        shadowAndCornerConfig.shadowRadius = 5
        shadowAndCornerConfig.cornerRadius = 5
        
        config.shadowAndCornerConfig = shadowAndCornerConfig
        return config
    }
}

