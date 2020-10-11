//
//  ViewController.swift
//  Example
//
//  Created by Amirthy Tejeshwar on 08/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit
import CustomDropDown

class ViewController: UIViewController {

    let items = ["first new hey", "second name", "third name"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ccp = CustomDropDownPresenter<String>(items: items, delegate: self)
        let newView = ccp.getDropDownView()
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newView.backgroundColor = .red
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

extension ViewController: CustomDropDownDelegate, CustomDropDownDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UIView()
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Headersection", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        cell.backgroundColor = .lightGray
        cell.addSubview(label)
        label.addAnchors(top: cell.topAnchor, bottom: cell.bottomAnchor, left: cell.leftAnchor, right: cell.rightAnchor, padding: 8, widthConstraint: nil, heightConstraint: label.heightAnchor.constraint(greaterThanOrEqualToConstant: 32))
        return cell
    }
    
    func overrideDropDownView() -> UIView? {
        let customView = UIView()
        let title = UILabel()
        let button = UIImageView(image: UIImage(named: "arrow-down"))
        customView.addSubview(title)
        customView.addSubview(button)
        title.addAnchors(top: customView.topAnchor, bottom: customView.bottomAnchor, left: customView.leftAnchor, right: button.leftAnchor, padding: 8, widthConstraint: nil, heightConstraint: title.heightAnchor.constraint(greaterThanOrEqualToConstant: 32))
        title.attributedText = NSAttributedString(string: "My Custom hello", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        button.addAnchors(top: nil, bottom: nil, left: nil, right: customView.rightAnchor, padding: 16, widthConstraint: button.widthAnchor.constraint(equalToConstant: 32), heightConstraint: button.heightAnchor.constraint(equalToConstant: 32))
        button.centerYAnchor.constraint(equalTo: customView.centerYAnchor).isActive = true
        return customView
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
