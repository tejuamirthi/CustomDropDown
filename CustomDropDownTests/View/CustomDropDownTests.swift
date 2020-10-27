//
//  CustomDropDownTests.swift
//  CustomDropDownTests
//
//  Created by Jacqueline Alves on 27/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import XCTest

@testable import CustomDropDown

class CustomDropDownTests: XCTestCase {
    var sut: CustomDropDown<String>!
    var dummyDropDownView: CustomDropDownView<String>!
    var dummyPresenter: CustomDropDownPresenter<String>!
    let dummyDelegate = CustomDropDownDelegateAndDataSourceDummy()
    let tag: Int = 0

    override func setUp() {
        super.setUp()
        
        dummyPresenter = CustomDropDownPresenter<String>(items: [], delegate: dummyDelegate)
        dummyDropDownView = CustomDropDownView<String>(delegate: dummyPresenter, identifier: 0)
        sut = CustomDropDown<String>(dropDownView: dummyDropDownView, tag: tag)
    }

    override func tearDown() {
        sut = nil
        dummyDropDownView = nil
        dummyPresenter = nil
        
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertEqual(sut.tag, tag)
    }
    
    func testViewSetup() {
        XCTAssertEqual(sut.tableView.superview, sut)
    }

    func testTableViewSetup() {
        XCTAssertTrue(sut.tableView.delegate === dummyDropDownView)
        XCTAssertTrue(sut.tableView.dataSource === dummyDropDownView)
    }
    
    func testTableCellRegister() {
        XCTAssertNotNil(sut.tableView.dequeueReusableCell(withIdentifier: "UILabel"))
        XCTAssertNotNil(sut.tableView.dequeueReusableCell(withIdentifier: DropDownImageLabelView.reuseIdentifier))
    }
    
    func testSetCornerRadius() {
        let cornerRadius: CGFloat = 20
        sut.cornerRadius = cornerRadius
        
        XCTAssertEqual(sut.tableView.layer.cornerRadius, cornerRadius)
        XCTAssertTrue(sut.tableView.layer.masksToBounds)
    }
}
