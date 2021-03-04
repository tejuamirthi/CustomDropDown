//
//  ViewController.swift
//  Example
//
//  Created by Amirthy Tejeshwar on 08/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//
import UIKit
import CustomDropDown

class LabelStyleViewController: UIViewController {

    let items = ["myown", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", "second name", "third name"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let ccp = CustomDropDownPresenter<String>(items: items, delegate: self)
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
extension LabelStyleViewController: CustomDropDownDelegate, CustomDropDownDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any?, identifier: Int) {
        
    }
    
    func config(identifier: Int) -> DropDownConfig {
        var config = DropDownConfig()
        config.backgroundColor = .gray
        config.selectedColor = .orange
        var shadowAndCornerConfig = ShadowAndCornerConfig()
        shadowAndCornerConfig.shadowOffset = CGSize(width: 5, height: 5)
        shadowAndCornerConfig.shadowOpacity = 0.8
        shadowAndCornerConfig.shadowRadius = 5
        shadowAndCornerConfig.cornerRadius = 5
        
        config.shadowAndCornerConfig = shadowAndCornerConfig
        return config
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
