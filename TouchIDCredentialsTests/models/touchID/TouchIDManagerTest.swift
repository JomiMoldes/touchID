//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import XCTest
import LocalAuthentication

@testable import TouchIDCredentials

class TouchIDManagerTest: XCTestCase {

    var sut : TouchIDProtocol!

    override class func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testMinVersion() {
        mockSUT()
        XCTAssertTrue(sut.shouldShowTouchIDButton())

        (sut as! TouchIDManagerFake).supportsMinVersion = false
        XCTAssertFalse(sut.shouldShowTouchIDButton())
    }

    func testCheckIDWithoutMinVersion() {
        mockSUT()
        (sut as! TouchIDManagerFake).supportsMinVersion = false
        sut.checkID(completion:{
            success in
            XCTAssertFalse(success)
        })
    }

    func testCheckInPolicyEvaluation() {
        mockSUT()
        sut.checkID(completion:{
            success in
            XCTAssertTrue(success)
        })
        (sut.context as! TouchIDContextWrapperFake).canEvaluate = false
        sut.checkID(completion:{
            success in
            XCTAssertFalse(success)
        })
    }

    private func mockSUT() {
        sut = TouchIDManagerFake()
        (sut as! TouchIDManagerFake).supportsMinVersion = true
        sut.context = TouchIDContextWrapperFake()
        (sut.context as! TouchIDContextWrapperFake).canEvaluate = true
    }

}