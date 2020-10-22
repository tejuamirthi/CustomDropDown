//
//  DropDownImageLabelView.swift
//  CustomDropDown
//
//  Created by Jacqueline Alves on 22/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

class DropDownImageLabelView: UITableViewCell {
    
    // MARK: - Constants
    
    let padding: CGFloat = 16
    let imageSize: CGFloat = 32
    let titleMinHeight: CGFloat = 32
    let fontSize: CGFloat = 16
    
    // MARK: - Variables
    
    static var reuseIdentifier: String = "DropDownImageLabelView"
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.attributedText = NSAttributedString(string: "",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        return view
    }()
    
    lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupView()
    }
    
    func setup(image: UIImage?, title: String?, lines: Int) {
        leftImageView.image = image
        
        titleLabel.numberOfLines = lines
        titleLabel.attributedText = NSAttributedString(string: title ?? "",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
    }
}

// MARK: - ViewCode

extension DropDownImageLabelView: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(leftImageView)
    }
    
    func setupConstraints() {
        // Title
        titleLabel.addAnchors(top: contentView.topAnchor,
                         bottom: contentView.bottomAnchor,
                         left: nil,
                         right: contentView.rightAnchor,
                         padding: padding,
                         widthConstraint: nil,
                         heightConstraint: titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: titleMinHeight))
        
        // Left image view
        leftImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        leftImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding).isActive = true
        leftImageView.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -padding).isActive = true
        leftImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
}
