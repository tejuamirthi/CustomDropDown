//
//  ImageLabelData.swift
//  CustomDropDown
//
//  Created by Jacqueline Alves on 22/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public struct ImageLabelData {
    public var title: String?
    public var image: UIImage?
    
    public init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}


public class MultiSelectData {
    public var title: String?
    public var isSelected: Bool?
    
    public init(title: String?, isSelected: Bool?) {
        self.title = title
        self.isSelected = isSelected
    }
    
    func equal(val: MultiSelectData?) -> Bool {
        return self.title == val?.title
    }
}
