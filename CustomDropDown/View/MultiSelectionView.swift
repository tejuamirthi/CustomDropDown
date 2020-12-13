//
//  MultiSelectionView.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 12/12/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

class MultiSelectDisplayView: UIView {
    
    weak var dropDownView: CustomDropDownView<MultiSelectData>?
    var collectionView: UICollectionView
    
    var getItems: [MultiSelectData]
    
//    var selectedValues: [IndexPath] = []
    
    init(tag: Int, dropDownView: CustomDropDownView<MultiSelectData>?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        getItems = dropDownView?.presenter?.items.filter({ ($0.isSelected ?? false) }) ?? []
        super.init(frame: .zero)
        self.dropDownView = dropDownView
        self.backgroundColor = .clear
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        commonInit()
    }
    
    func calculateItems() -> [MultiSelectData] {
        return dropDownView?.presenter?.items.filter({ ($0.isSelected ?? false) }) ?? []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    func commonInit() {
        addSubview(collectionView)
        collectionView.addAnchors(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, padding: 8, widthConstraint: nil, heightConstraint: nil)
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleDropDownIfNot(_:)))
//        collectionView.addGestureRecognizer(tapGestureRecognizer)
//        tapGestureRecognizer.cancelsTouchesInView = false
//        tapGestureRecognizer.delegate = self
    }
    
//    @objc func toggleDropDownIfNot(_ gesture: UITapGestureRecognizer) {
//        dropDownView?.toggleDropDown()
////        self.sendTo
//    }
    
    deinit {
        collectionView.gestureRecognizers?.removeAll()
    }
}

extension MultiSelectDisplayView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MultiSelectDisplayView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let _ = cell.contentView.subviews.map { (view) -> () in
            view.removeFromSuperview()
        }
        let label = UILabel()
        label.text = getItems[indexPath.row].title
        let button = UIButton()
        button.setImage(UIImage(systemName: "clear.fill"), for: .normal)
        cell.contentView.addSubview(label)
        cell.contentView.addSubview(button)
        cell.backgroundColor = .gray
        let buttonHeightWidth: CGFloat = 0 // should be changed later
        label.addAnchors(top: cell.contentView.topAnchor, bottom: cell.contentView.bottomAnchor, left: cell.contentView.leftAnchor, right: button.rightAnchor, padding: 8, widthConstraint: nil, heightConstraint: nil)
        button.addAnchors(top: cell.contentView.topAnchor, bottom: cell.contentView.bottomAnchor, left: nil, right: cell.contentView.rightAnchor, padding: 8, widthConstraint: button.widthAnchor.constraint(equalToConstant: buttonHeightWidth), heightConstraint: button.heightAnchor.constraint(equalToConstant: buttonHeightWidth))
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item: MultiSelectData = dropDownView?.presenter?.items[indexPath.row] else {
            return
        }
        item.isSelected = false
        dropDownView?.didSelectDisplayView(data: item)
//        dropDownView?.tableView(dropDownView?.dropDown?.tableView, didSelectRowAt: in)
//        collectionView.deleteItems(at: [indexPath])
        reloadItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 116, height: 48)
    }
    
    func reloadItems() {
        getItems = calculateItems()
        collectionView.reloadData()
    }
}
