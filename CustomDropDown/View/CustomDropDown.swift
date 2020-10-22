//
//  CustomDropDown.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 04/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public class DropDownDisplayView: UIView {
    open var title: UILabel!
    init(tag: Int) {
        super.init(frame: .zero)
        title = UILabel()
        self.addSubview(title)
        title.tag = tag
        title.addAnchors(top: self.topAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, padding: 8, widthConstraint: nil, heightConstraint: title.heightAnchor.constraint(greaterThanOrEqualToConstant: 32))
        title.attributedText = NSAttributedString(string: "Select-hello", attributes: [NSAttributedString.Key.foregroundColor :UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public struct ImageLabelData {
    public var title: String?
    public var image: UIImage?
    
    public init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}

class DropDownImageLabelView: UITableViewCell {
    var title: UILabel!
    var leftImageView: UIImageView!
    var imageWidthConstraint: NSLayoutConstraint!
    var imageHeightConstraint: NSLayoutConstraint!
    var imageLeadingConstraint: NSLayoutConstraint!
    var imageTrailingConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        title = UILabel()
        leftImageView = UIImageView()
        self.contentView.addSubview(title)
        self.contentView.addSubview(leftImageView)
        setupConstraints()
        title.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
    }
    
    func setupConstraints() {
        title.addAnchors(top: self.contentView.topAnchor, bottom: self.contentView.bottomAnchor, left: nil, right: self.contentView.rightAnchor, padding: 16, widthConstraint: nil, heightConstraint: title.heightAnchor.constraint(greaterThanOrEqualToConstant: 32))
        
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        imageWidthConstraint = leftImageView.widthAnchor.constraint(equalToConstant: 32)
        imageHeightConstraint = leftImageView.heightAnchor.constraint(equalToConstant: 32)
        imageLeadingConstraint = leftImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16)
        imageTrailingConstraint = leftImageView.rightAnchor.constraint(equalTo: title.leftAnchor, constant: -16)
        leftImageView.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        NSLayoutConstraint.activate([
            imageWidthConstraint, imageHeightConstraint, imageLeadingConstraint, imageTrailingConstraint
        ])
    }
}

class CustomDropDownView<T>: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var dropDown: CustomDropDown<T>?
    var isOpen = true
    var presenter: CustomDropDownPresenter<T>?
    var heightConstraint = NSLayoutConstraint()
    var dropDownDisplayView: UIView!
    var config: DropDownConfig = DropDownConfig()
    var identifier: Int
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = presenter?.datasource?.numberOfSections(in: tableView, identifier: identifier) {
            return sections
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        presenter?.datasource?.tableView(tableView, heightForHeaderInSection: section, identifier: identifier) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return presenter?.datasource?.tableView(tableView, viewForHeaderInSection: section, identifier: identifier)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.datasource?.tableView(tableView, heightForRowAt: indexPath, identifier: identifier) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = presenter?.datasource?.tableView(tableView, numberOfRowsInSection: section, identifier: identifier) {
            return rows
        }
        return presenter?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = presenter?.datasource?.tableView(tableView, cellForRowAt: indexPath, identifier: identifier) {
            return cell
        } else if config.dropDownMode == .label {
            return getStringLabelCell(tableView: tableView, indexPath: indexPath)
        } else {
            return getImageLabelCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = self.presenter else {
            return
        }
        presenter.delegate?.tableView(tableView, didSelectRowAt: indexPath, displayView: dropDownDisplayView, config: config, data: presenter.items[indexPath.row], identifier: identifier)
        self.toggleDropDown()
    }

    func getImageLabelCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownImageLabelView") as? DropDownImageLabelView, let items = presenter?.items as? [ImageLabelData] else {
            return UITableViewCell()
        }
        cell.title.numberOfLines = 0
        cell.title.attributedText = NSAttributedString(string: items[indexPath.row].title ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        cell.leftImageView.image = items[indexPath.row].image
        return cell
    }

    
    func getStringLabelCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UILabel") else {
            return UITableViewCell()
        }
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: presenter?.items[indexPath.row] as? String ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        cell.contentView.addSubview(label)
        cell.contentView.backgroundColor = .gray
        label.addAnchors(top: cell.contentView.topAnchor, bottom: cell.contentView.bottomAnchor, left: cell.contentView.leftAnchor, right: cell.contentView.rightAnchor, padding: 16, widthConstraint: nil, heightConstraint: label.heightAnchor.constraint(greaterThanOrEqualToConstant: 32))
        return cell
    }
    
    init(delegate: CustomDropDownPresenter<T>, identifier: Int) {
        self.identifier = identifier
        super.init(frame: .zero)
        self.presenter = delegate
        setConfig()
        if let view = delegate.datasource?.overrideDropDownView(identifier: identifier) {
            dropDownDisplayView = view
        } else{
            setupDropDownDisplayView()
        }
        self.addSubview(dropDownDisplayView)
        dropDownDisplayView.addAnchors(top: self.topAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, padding: 8, widthConstraint: nil, heightConstraint: nil)
        setupDropDown()
        
    }
    
    func setConfig() {
        guard let config = self.presenter?.datasource?.config(identifier: identifier) else {
            return
        }
        self.config = config
        if T.self == ImageLabelData.self {
            self.config.dropDownMode = .imageLabel
        } else if T.self == String.self {
            self.config.dropDownMode = .label
        } else {
            fatalError("not supported item tyoe")
        }
    }
    
    func setupDropDownDisplayView() {
        let tag = config.selectedLabelTag
        dropDownDisplayView = DropDownDisplayView(tag: tag)
    }
    
    func setupDropDown() {
        dropDown = CustomDropDown<T>(dropDownView: self, tag: config.dropDownTag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //location is relative to the current view
        // do something with the touched point
        super.touchesBegan(touches, with: event)
        toggleDropDown()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let dropDown = self.dropDown else {
            return
        }
        if let view = self.superview?.viewWithTag(config.dropDownTag) {
            view.removeFromSuperview()
        }
        self.superview?.addSubview(dropDown)
        self.superview?.bringSubviewToFront(dropDown)
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        let dropDownLeftRightPadding: UIEdgeInsets = self.config.dropDownLeftRightPadding
        dropDown.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -dropDownLeftRightPadding.top).isActive = true
        dropDown.leftAnchor.constraint(equalTo: self.leftAnchor, constant: dropDownLeftRightPadding.left).isActive = true
        if let dropDownWidth = config.dropDownWidth {
            dropDown.widthAnchor.constraint(equalToConstant: dropDownWidth).isActive = true
        } else {
            dropDown.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -dropDownLeftRightPadding.right).isActive = true
        }
        heightConstraint = dropDown.heightAnchor.constraint(equalToConstant: 0)
    }
    
    func getDisplayView() {
        return 
    }
    
    func toggleDropDown() {
        guard let dropDown = self.dropDown else {
            return
        }
        if isOpen {
            isOpen = false
            NSLayoutConstraint.deactivate([heightConstraint])
            var height: CGFloat = 200
            if height > dropDown.tableView.contentSize.height {
                height = dropDown.tableView.contentSize.height
            }
            self.superview?.bringSubviewToFront(dropDown)
            self.heightConstraint.constant = height
            NSLayoutConstraint.activate([heightConstraint])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                dropDown.layoutIfNeeded()
                dropDown.center.y += dropDown.frame.height/2
            })
        } else {
            isOpen = true
            NSLayoutConstraint.deactivate([heightConstraint])
            heightConstraint.constant = 0
            NSLayoutConstraint.activate([heightConstraint])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                dropDown.center.y -= dropDown.frame.height/2
                dropDown.layoutIfNeeded()
            })
        }
    }
}


class CustomDropDown<T>: UIView {
    
    var tableView: UITableView = UITableView()
    
    init(dropDownView: CustomDropDownView<T>, tag: Int) {
        super.init(frame: .zero)
        self.tag = tag
        tableView.dataSource = dropDownView
        tableView.delegate = dropDownView
        tableView.register(DropDownImageLabelView.self, forCellReuseIdentifier: "DropDownImageLabelView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UILabel")
        tableView.backgroundColor = .lightGray
        self.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
