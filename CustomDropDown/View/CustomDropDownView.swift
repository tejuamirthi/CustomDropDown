//
//  CustomDropDownView.swift
//  CustomDropDown
//
//  Created by Jacqueline Alves on 22/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

class CustomDropDownView<T>: UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: - Constants
    
    let padding: CGFloat = 8
    let dropDownHeight: CGFloat = 200
    
    // MARK: - Variables
    
    var presenter: CustomDropDownPresenter<T>?
    var config: DropDownConfig = DropDownConfig()
    var dropDown: CustomDropDown<T>?
    var dropDownDisplayView: UIView!
    var heightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var isOpen: Bool = false
    var guestureIdentifierBool: Bool = true
    var identifier: Int
    var outsideGesture: UITapGestureRecognizer?
    var insideTapGesture: UITapGestureRecognizer?
    
    var selectedCellIndex = ""
    var listColor: UIColor = .lightGray
    var selectedColor: UIColor = .red
    
    // MARK: - Life cycle
    
    init(delegate: CustomDropDownPresenter<T>, identifier: Int, listColor: UIColor?=nil, selectedColor: UIColor?=nil) {
        self.identifier = identifier
        self.presenter = delegate
        if let colorList = listColor, let colorSelected = selectedColor {
            self.listColor = colorList
            self.selectedColor = colorSelected

        }
        super.init(frame: .zero)
        
        setConfig()
        setupDropDownDisplayView()
        setupDropDown()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfig() {
        guard let config = self.presenter?.datasource?.config(identifier: identifier) else { return }
        
        self.config = config
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let view = self.superview?.viewWithTag(config.dropDownTag) {
            view.removeFromSuperview()
        }
        
        resetDropDownConstraints()
    }
    
    // MARK: - DropDown
    
    private func setupDropDownDisplayView() {
        if config.dropDownMode == .custom, let view = presenter?.datasource?.overrideDropDownView(identifier: identifier) {
            dropDownDisplayView = view
        } else if config.dropDownMode == .multiSelect {
            dropDownDisplayView = MultiSelectDisplayView(tag: 1, dropDownView: self as? CustomDropDownView<MultiSelectData>)
        } else {
            let tag = config.selectedLabelTag
            dropDownDisplayView = DropDownDisplayView(tag: tag)
        }
        
        self.insideTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleDropDown(_:)))
        dropDownDisplayView.addGestureRecognizer(insideTapGesture!)
        insideTapGesture?.delegate = self
    }
    
    @objc func toggleDropDown(_ gestureRecognizer: UITapGestureRecognizer) {
        toggleDropDown()
    }
    
    private func setupDropDown() {
        dropDown = CustomDropDown<T>(dropDownView: self, tag: config.dropDownTag)
        dropDown?.translatesAutoresizingMaskIntoConstraints = false

        dropDown?.cornerRadius = config.shadowAndCornerConfig.cornerRadius
        
        dropDown?.layer.shadowColor = config.shadowAndCornerConfig.shadowColor
        dropDown?.layer.shadowOpacity = config.shadowAndCornerConfig.shadowOpacity
        dropDown?.layer.shadowOffset = config.shadowAndCornerConfig.shadowOffset
        dropDown?.layer.shadowRadius = config.shadowAndCornerConfig.shadowRadius
    }
    
    private func resetDropDownConstraints() {
        guard let dropDown = dropDown, let superview = superview else { return }
        
        superview.addSubview(dropDown)
        superview.bringSubviewToFront(dropDown)
        
        let dropDownLeftRightPadding: UIEdgeInsets = config.dropDownLeftRightPadding
        
        dropDown.topAnchor.constraint(equalTo: bottomAnchor, constant: -dropDownLeftRightPadding.top).isActive = true
        dropDown.leftAnchor.constraint(equalTo: leftAnchor, constant: dropDownLeftRightPadding.left).isActive = true
        
        if let dropDownWidth = config.dropDownWidth {
            dropDown.widthAnchor.constraint(equalToConstant: dropDownWidth).isActive = true
        } else {
            dropDown.rightAnchor.constraint(equalTo: rightAnchor, constant: -dropDownLeftRightPadding.right).isActive = true
        }
        
        heightConstraint = dropDown.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func toggleDropDown() {
        if isOpen {
            closeDropDown()
        } else if guestureIdentifierBool {
            openDropDown()
        } else {
            // need this to handle and check tapgesture on the display view
            guestureIdentifierBool = true
        }
    }
    
    private func openDropDown() {
        guard let dropDown = self.dropDown else { return }
        isOpen = true
        addOutsideGesture()
        setHeightConstraint(to: dropDownHeight, maxHeight: dropDown.tableView.contentSize.height)
        superview?.bringSubviewToFront(dropDown)
        animateDropDown(animations: {
            dropDown.layoutIfNeeded()
            dropDown.center.y += dropDown.frame.height/2
        })
    }
    
    private func closeDropDown() {
        guard let dropDown = self.dropDown else { return }
        isOpen = false
        removeOutsideGesture()
        setHeightConstraint(to: 0)
        animateDropDown(animations: {
            dropDown.center.y -= dropDown.frame.height/2
            dropDown.layoutIfNeeded()
        })
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05, execute: {
            // need this to handle outside tap gesture (dropdown takes two taps to open if not handled here)
            self.guestureIdentifierBool = true
        })
    }
    
    private func setHeightConstraint(to height: CGFloat, maxHeight: CGFloat? = nil) {
        var height: CGFloat = height
        if let maxHeight = maxHeight, height > maxHeight {
            height = maxHeight
        }
        
        NSLayoutConstraint.deactivate([heightConstraint])
        heightConstraint.constant = height
        NSLayoutConstraint.activate([heightConstraint])
    }
    
    private func animateDropDown(animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: completion)
    }
    
    private func addOutsideGesture() {
        guard outsideGesture == nil else { return }
        let rootView = window?.topViewController()?.view
        outsideGesture = UITapGestureRecognizer(target: self, action: #selector(outsideGestureHandler))
        outsideGesture!.cancelsTouchesInView = false
        outsideGesture!.delegate = self
        rootView?.addGestureRecognizer(outsideGesture!)
    }
    
    private func removeOutsideGesture() {
        let rootView = window?.topViewController()?.view
        if let tap = outsideGesture {
            rootView?.removeGestureRecognizer(tap)
        }
        outsideGesture = nil
    }
    
    // This func is called even when user click on tableview row. So, to avoid conflicts
    // is necessary to detect if tap is not over DropDown to close it.
    @objc func outsideGestureHandler(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: dropDown)
        let wh = (w: dropDown?.frame.width ?? 0, h: dropDown?.frame.height ?? 0)
        let tapOutsiteOfDropDown = (location.x < 0 || location.y < 0 || location.x > wh.w || location.y > wh.h)
        if isOpen && tapOutsiteOfDropDown {
            closeDropDown()
            guestureIdentifierBool = false
        }
    }
    
    // MARK: - Table View
    
    private func getImageLabelCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownImageLabelView.reuseIdentifier) as? DropDownImageLabelView,
              let items = presenter?.items as? [ImageLabelData] else {
            return UITableViewCell()
        }
        
        cell.setup(image: items[indexPath.row].image,
                   title: items[indexPath.row].title,
                   lines: 0)
        
        if selectedCellIndex == "\(indexPath.row)" {
            cell.backgroundColor = selectedColor
        } else {
            cell.backgroundColor = listColor
        }
        
        return cell
    }

    private func getMultiSelectCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownMultiSelectionView.reuseIdentifier) as? DropDownMultiSelectionView,
              let items = presenter?.items as? [MultiSelectData] else {
            return UITableViewCell()
        }
        
        cell.setup(item: items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    private func getStringLabelCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UILabel") else {
            return UITableViewCell()
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = presenter?.items[indexPath.row] as? String
//        cell.contentView.backgroundColor = .gray
        if selectedCellIndex == "\(indexPath.row)" {
            cell.backgroundColor = selectedColor
        } else {
            cell.backgroundColor = listColor
        }
        
        return cell
    }
    
    // MARK: UIGestureRecognizerDelegate methods
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return !((gestureRecognizer == insideTapGesture && otherGestureRecognizer == outsideGesture) || (gestureRecognizer == outsideGesture && otherGestureRecognizer == insideTapGesture))
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = presenter?.datasource?.tableView(tableView, numberOfRowsInSection: section, identifier: identifier) {
            return rows
        }
        return presenter?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch config.dropDownMode {
        case .label:
            return getStringLabelCell(tableView: tableView, indexPath: indexPath)
        case .imageLabel:
            return getImageLabelCell(tableView: tableView, indexPath: indexPath)
        case .multiSelect:
            return getMultiSelectCell(tableView: tableView, indexPath: indexPath)
        case .custom:
            if let cell = presenter?.datasource?.tableView(tableView, cellForRowAt: indexPath, identifier: identifier) {
                return cell
            }
            return UITableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndex = "\(indexPath.row)"

        presenter?.delegate?.tableView(tableView, didSelectRowAt: indexPath, data: presenter?.items[indexPath.row], identifier: identifier)
        switch config.dropDownMode {
        case .multiSelect:
            guard let multiSelectDisplayView = dropDownDisplayView as? MultiSelectDisplayView, let items = presenter?.items as? [MultiSelectData] else {
                return
            }
            items[indexPath.row].isSelected?.toggle()
//                multiSelectDisplayView.selectedValues.remove(at: index)
            multiSelectDisplayView.reloadItems()
            tableView.reloadRows(at: [indexPath], with: .automatic)
//            (tableView.cellForRow(at: indexPath) as? DropDownMultiSelectionView)?.didSelect(tableView: tableView, indexPath: indexPath)
        case .imageLabel:
//            setSelectedLabelText(text: (presenter?.items[indexPath.row] as? ImageLabelData)?.title)
            
            if let validTitle = (presenter?.items[indexPath.row] as? ImageLabelData)?.title, let validImage = (presenter?.items[indexPath.row] as? ImageLabelData)?.image {
                setSelectedLabelText(text: validTitle, image: validImage)
            }
        
        case .label:
            setSelectedLabelText(text: presenter?.items[indexPath.row] as? String)
        default:
            presenter?.delegate?.tableView(tableView, didSelectRowAt: indexPath, displayView: dropDownDisplayView, data: presenter?.items[indexPath.row], identifier: identifier)
        }
        
        if config.dropDownCollapsable {
            toggleDropDown()
            tableView.reloadData()
        }
    }
    
    func didSelectDisplayView(data: MultiSelectData) {
        let index = presenter?.items.firstIndex { (value) -> Bool in
            data.equal(val: value as? MultiSelectData)
        }
        if let indexValue = index {
            dropDown?.tableView.reloadRows(at: [IndexPath(row: indexValue, section: 0)], with: .automatic)
        }
    }
    
    func setSelectedLabelText(text: String?, image: UIImage?=nil) {
        if let stackView = dropDownDisplayView.viewWithTag(config.selectedLabelTag) as? UIStackView {
            let arrangedViews = stackView.arrangedSubviews
            
            for view in arrangedViews {
                switch view.tag {
                case 1111:
                    let labelView = view as? UILabel
                    if let validLabel = labelView {
                        validLabel.text = text
                    }
                case 2222:
                    let imageView = view as? UIImageView
                    if let validImage = imageView {
                        validImage.image = image
                    }
                default:
                    print("not valid tag")
                }

            }

        }
    }
}

// MARK: - ViewCode

extension CustomDropDownView: ViewCode {
    func buildViewHierarchy() {
        addSubview(dropDownDisplayView)
    }
    
    func setupConstraints() {
        dropDownDisplayView.addAnchors(top: topAnchor,
                                       bottom: bottomAnchor,
                                       left: leftAnchor,
                                       right: rightAnchor,
                                       padding: padding,
                                       widthConstraint: nil,
                                       heightConstraint: nil)
    }
}
