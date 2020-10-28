//
//  ImageLabelStyleViewController.swift
//  Example
//
//  Created by Franklin Samboni on 26/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit
import CustomDropDown

class ImageLabelStyleViewController: UIViewController {

    let items = [ImageLabelData(title: "Go hard", image: UIImage(systemName: "heart.fill")),
                 ImageLabelData(title: "Go home", image: UIImage(systemName: "house.fill")),
                 ImageLabelData(title: "Try again", image: UIImage(systemName: "repeat"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let ccp = CustomDropDownPresenter<ImageLabelData>(items: items, delegate: self)
        let newView = ccp.getDropDownView()
        
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newView.backgroundColor = .darkGray
    }
    
}

extension ImageLabelStyleViewController: CustomDropDownDelegate, CustomDropDownDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any, identifier: Int) {
        
    }
    
    func config(identifier: Int) -> DropDownConfig {
        var config = DropDownConfig()
        
        config.dropDownMode = .imageLabel
        var shadowAndCornerConfig = ShadowAndCornerConfig()
        shadowAndCornerConfig.shadowOffset = CGSize(width: 5, height: 5)
        shadowAndCornerConfig.shadowOpacity = 0.8
        shadowAndCornerConfig.shadowRadius = 5
        shadowAndCornerConfig.cornerRadius = 5
        
        config.shadowAndCornerConfig = shadowAndCornerConfig
        return config
    }
}
