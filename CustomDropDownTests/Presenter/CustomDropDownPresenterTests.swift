//
//  CustomDropDownPresenterTests.swift
//  CustomDropDownTests
//
//  Created by Jacqueline Alves on 27/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import XCTest

@testable import CustomDropDown

class CustomDropDownPresenterTests: XCTestCase {
    var sut: CustomDropDownPresenter<String>!
    let dummyDelegate = CustomDropDownDelegateAndDataSourceDummy()
    let items: [String] = ["item 1", "item 2", "item 3"]

    override func setUp() {
        super.setUp()
        sut = CustomDropDownPresenter<String>(items: items, delegate: dummyDelegate)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testVariablesSet() {
        XCTAssertEqual(sut.items, items)
        XCTAssertTrue(sut.datasource === dummyDelegate)
        XCTAssertTrue(sut.delegate === dummyDelegate)
        XCTAssertNotNil(sut.dropDown)
    }
    
    func testGetDropDownView() {
        XCTAssertEqual(sut.getDropDownView(), sut.dropDown)
    }
}
