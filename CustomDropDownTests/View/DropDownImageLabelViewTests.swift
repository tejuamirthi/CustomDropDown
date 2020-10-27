//
//  DropDownImageLabelViewTests.swift
//  CustomDropDownTests
//
//  Created by Jacqueline Alves on 27/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import XCTest

@testable import CustomDropDown

class DropDownImageLabelViewTests: XCTestCase {
    var sut: DropDownImageLabelView!

    override func setUp() {
        super.setUp()
        
        sut = DropDownImageLabelView(style: .default, reuseIdentifier: "DropDownImageLabelView")
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testViewSetup() {
        XCTAssertEqual(sut.titleLabel.superview, sut.contentView)
        XCTAssertFalse(sut.titleLabel.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(sut.leftImageView.superview, sut.contentView)
        XCTAssertFalse(sut.leftImageView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testSetup() {
        let image = UIImage(named: "arrow-down")
        let title = "Circle"
        let lines = 0
        
        sut.setup(image: image, title: title, lines: lines)
        
        XCTAssertEqual(sut.titleLabel.numberOfLines, lines)
        XCTAssertEqual(sut.titleLabel.text, title)
        XCTAssertEqual(sut.titleLabel.textColor, .black)
        XCTAssertEqual(sut.titleLabel.font.pointSize, sut.fontSize)
        XCTAssertEqual(sut.leftImageView.image, image)
    }
    
    func testTitleStyle() {
        XCTAssertEqual(sut.titleLabel.textColor, UIColor.black)
        XCTAssertEqual(sut.titleLabel.font.pointSize, sut.fontSize)
    }
}
