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

    let items = ["first item", "second name", "third name", "fourth item", "fifth name", "sixth name", "seventh item", "eight name", "ninth name"]
    
    let imageItems = [ImageLabelData(title: "Football", image: UIImage(named: "football")), ImageLabelData(title: "Rugby", image: UIImage(named: "rugby"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        
        
//        let ccpImage = CustomDropDownPresenter<ImageLabelData>(items: imageItems, delegate: self)
//        let newViewImage = ccpImage.getDropDownView()
//        view.addSubview(newViewImage)

//        let centerVerticallyImage = NSLayoutConstraint(item: newViewImage, attribute: .centerX, relatedBy: .equal,
//                                                  toItem: view, attribute: .centerX, multiplier: 1, constant: 0.0)
//        let centerHorizontallyImage = NSLayoutConstraint(item: newViewImage, attribute: .centerY, relatedBy: .equal,
//                                                    toItem: view,  attribute: .centerY, multiplier: 1.3, constant: 0)
//        NSLayoutConstraint.activate([centerVerticallyImage, centerHorizontallyImage])
//        newViewImage.translatesAutoresizingMaskIntoConstraints = false
//        newViewImage.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
//        newViewImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        newViewImage.backgroundColor = .orange
        
        
        let ccp = CustomDropDownPresenter<String>(items: items, delegate: self)
        let newView = ccp.getDropDownView()
        view.addSubview(newView)
//
//        let centerVertically = NSLayoutConstraint(item: newView, attribute: .centerX, relatedBy: .equal,
//                                                  toItem: view, attribute: .centerX, multiplier: 1, constant: 0.0)
//        let centerHorizontally = NSLayoutConstraint(item: newView, attribute: .centerY, relatedBy: .equal,
//                                                    toItem: view, attribute: .centerY, multiplier: 0.5, constant: 0)
//        NSLayoutConstraint.activate([centerVertically, centerHorizontally])
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newView.backgroundColor = .red
    }
}

extension ViewController: CustomDropDownDelegate, CustomDropDownDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any, identifier: Int) {
        
    }
    
    func config(identifier: Int) -> DropDownConfig {
        var config = DropDownConfig()
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
