//
//  CustomDropDownViewTests.swift
//  CustomDropDownTests
//
//  Created by Jacqueline Alves on 27/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import XCTest

@testable import CustomDropDown

class CustomDropDownViewTests: XCTestCase {
    var sut: CustomDropDownView<String>!
    var dummyPresenter: CustomDropDownPresenter<String>!
    let dummyDelegate = CustomDropDownDelegateAndDataSourceDummy()
    let identifier: Int = 0
    let config = DropDownConfig()

    override func setUp() {
        super.setUp()
        
        dummyDelegate.config = config
        dummyPresenter = CustomDropDownPresenter<String>(items: [], delegate: dummyDelegate)
        sut = CustomDropDownView<String>(delegate: dummyPresenter, identifier: identifier)
    }

    override func tearDown() {
        sut = nil
        dummyPresenter = nil
        
        super.tearDown()
    }

    func testVariableSet() {
        XCTAssertEqual(sut.identifier, identifier)
        XCTAssertEqual(sut.presenter, dummyPresenter)
    }
    
    func testViewSetup() {
        XCTAssertTrue(sut.dropDownDisplayView.superview === sut)
    }
    
    func testSetConfig() {
        XCTAssertNotNil(sut.config)
        XCTAssertEqual(sut.config.dropDownMode, .label)
    }
    
    func testSetupDropDown() {
        XCTAssertEqual(sut.dropDown?.tag, config.dropDownTag)
        XCTAssertFalse(sut.dropDown?.translatesAutoresizingMaskIntoConstraints ?? true)
        XCTAssertEqual(sut.dropDown?.cornerRadius, config.shadowAndCornerConfig.cornerRadius)
        XCTAssertEqual(sut.dropDown?.layer.shadowColor, config.shadowAndCornerConfig.shadowColor)
        XCTAssertEqual(sut.dropDown?.layer.shadowOpacity, config.shadowAndCornerConfig.shadowOpacity)
        XCTAssertEqual(sut.dropDown?.layer.shadowOffset, config.shadowAndCornerConfig.shadowOffset)
        XCTAssertEqual(sut.dropDown?.layer.shadowRadius, config.shadowAndCornerConfig.shadowRadius)
    }
}
