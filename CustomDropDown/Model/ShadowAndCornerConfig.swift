//
//  ShadowAndCornerConfig.swift
//  CustomDropDown
//
//  Created by Guilherme Andrade on 10/25/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import UIKit

public struct ShadowAndCornerConfig {
    public var shadowColor: CGColor = UIColor.black.cgColor
    public var shadowOffset: CGSize = .zero
    public var shadowOpacity: Float = 0
    public var shadowRadius: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    
    public init() {}
}
