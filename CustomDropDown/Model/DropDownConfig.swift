//
//  DropDownConfig.swift
//  CustomDropDown
//
//  Created by Jacqueline Alves on 22/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public struct DropDownConfig {
    public var dropDownWidth: CGFloat?
    public var dropDownTag: Int = 999
    public var selectedLabelTag: Int = 9999
    public var dropDownLeftRightPadding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    public var dropDownMode: DropDownMode = .label
    public var dropDownCollapsable: Bool = true
    public var shadowAndCornerConfig: ShadowAndCornerConfig = ShadowAndCornerConfig()
    
    public init() {}
}
