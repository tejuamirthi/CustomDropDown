//
//  DropDownDisplayView.swift
//  CustomDropDown
//
//  Created by Jacqueline Alves on 22/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public class DropDownDisplayView: UIView {
    
    // MARK: - Constants
    
    let padding: CGFloat = 8
    let minHeight: CGFloat = 32
    let fontSize: CGFloat = 16
    
    // MARK: - Variables
    
    lazy open var title: UILabel = {
        let view = UILabel()
        view.attributedText = NSAttributedString(string: "Select-hello",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        view.tag = 1111
        return view
    }()
    
    lazy open var image: UIImageView = {
        let image = UIImageView()
        image.tag = 2222
        return image
    }()

    lazy open var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.image, self.title])
        stackView.distribution = .fillProportionally
       return stackView
    }()
    
    // MARK: - Life cycle
    
    init(tag: Int) {
        super.init(frame: .zero)
        
        setupView()
        setupTitle(with: tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupTitle(with tag: Int) {
//        title.tag = tag
        stackView.tag = tag
    }
}

// MARK: - ViewCode

extension DropDownDisplayView: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.addAnchors(top: topAnchor,
                         bottom: bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         padding: padding,
                         widthConstraint: nil,
                         heightConstraint: title.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight))
    }
}
