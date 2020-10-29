//
//  CustomDropDownPresenter.swift
//  CustomDropDown
//
//  Created by Amirthy Tejeshwar on 04/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

//class DropDownItem: UIView {
//    open var title: String?
//}

public class CustomDropDownPresenter<T>: NSObject {
    
    // MARK: - Variables
    
    var items: [T]
    weak var datasource: CustomDropDownDataSource?
    weak var delegate: CustomDropDownDelegate?
    var dropDown: CustomDropDownView<T>!
    
    // MARK: - Life cycle
    
    public init(items: [T], delegate: CustomDropDownDelegate?, identifier: Int = 0) {
        self.items = items
        super.init()
        
        self.delegate = delegate
        self.datasource = delegate as? CustomDropDownDataSource
        
        dropDown = CustomDropDownView(delegate: self, identifier: identifier)
    }
    
    public func getDropDownView() -> UIView {
        return dropDown as UIView
    }
}
