//
//  DropDownMultiSelectView.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 29/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

class DropDownMultiSelectionView: UITableViewCell {
    
    // MARK: - Constants
    
    let padding: CGFloat = 16
    let imageSize: CGFloat = 32
    let titleMinHeight: CGFloat = 32
    let fontSize: CGFloat = 16
    var isChecked: Bool = false {
        didSet {
            var imageName = "square"
            if isChecked {
                imageName = "checkmark.square.fill"
            }
            self.leftImageView.image = UIImage(systemName: imageName)
            
        }
    }
    
    // MARK: - Variables
    
    static var reuseIdentifier: String = "DropDownMultiSelectionView"
    
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
    
    func setup(item: MultiSelectData) {
        isChecked = item.isSelected ?? false
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = NSAttributedString(string: item.title ?? "",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
    }
    
    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        isChecked.toggle()
    }
}

// MARK: - ViewCode

extension DropDownMultiSelectionView: ViewCode {
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
