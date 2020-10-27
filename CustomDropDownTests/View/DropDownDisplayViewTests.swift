//
//  DropDownDisplayViewTests.swift
//  CustomDropDownTests
//
//  Created by Jacqueline Alves on 27/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import XCTest

@testable import CustomDropDown

class DropDownDisplayViewTests: XCTestCase {
    var sut: DropDownDisplayView!
    let tag: Int = 0

    override func setUp() {
        super.setUp()
        
        sut = DropDownDisplayView(tag: tag)
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertEqual(sut.title.tag, tag)
    }
    
    func testViewSetup() {
        XCTAssertEqual(sut.title.superview, sut)
        XCTAssertFalse(sut.title.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testTitleStyle() {
        XCTAssertEqual(sut.title.textColor, UIColor.white)
        XCTAssertEqual(sut.title.font.pointSize, sut.fontSize)
    }
}
