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

    func testShouldShowTouchIDButton() {
        mockSUT()

        let asyncExpectation = expectation(description: "should show button expectation")

        sut.shouldShowTouchIDButton().then {
            success -> Void in
            XCTAssertTrue(success)
            asyncExpectation.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("error when checking for button")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("should check for button")
            }
        }
    }

    func testShouldNotShowButtonByMinVersion() {
        mockSUT()
        supportsMinVersion(false)

        let asyncExpectation = expectation(description: "should not show button expectation")

        sut.shouldShowTouchIDButton().then {
            success -> Void in
            XCTAssertFalse(success)
            asyncExpectation.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("error when checking for button")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("should check for button")
            }
        }
    }

    func testShouldNotShowButtonByNotBeingAbleToEvaluate() {
        mockSUT()
        canEvaluate(false)

        let asyncExpectation = expectation(description: "should not show button expectation")

        sut.shouldShowTouchIDButton().then {
            success -> Void in
            XCTFail("should receive an error")
            asyncExpectation.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTAssertTrue(true)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("should check for button")
            }
        }
    }

    func testCheckIDUnsuccessfulByMinimumVersion() {
        mockSUT()
        supportsMinVersion(false)

        let asyncExpectation = expectation(description: "should not show button expectation")

        sut.checkID().then {
            success -> Void in
            XCTAssertFalse(success)
            asyncExpectation.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("should fulfill unsuccessfully")
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("should check for button")
            }
        }
    }

    func testCheckIDUnsuccessfulByNotBeingAbleToEvaluate() {
        mockSUT()
        canEvaluate(false)

        let asyncExpectation = expectation(description: "should not show button expectation")

        sut.checkID().then {
            success -> Void in
            XCTFail("should receive an error")
            asyncExpectation.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTAssertTrue(true)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("should check for button")
            }
        }
    }

    func testCheckIDUnsuccessfulByWrongFinger() {
        mockSUT()
        evaluatesFinger(false)

        let asyncExpectation = expectation(description: "should not show button expectation")

        sut.checkID().then {
            success -> Void in
            XCTFail("should receive an error")
            asyncExpectation.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTAssertTrue(true)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("should check for button")
            }
        }
    }

    func testCheckIDSuccessful() {
        mockSUT()

        let asyncExpectation = expectation(description: "should not show button expectation")

        sut.checkID().then {
            success -> Void in
            XCTAssertTrue(success)
            asyncExpectation.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail()
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("should check for button")
            }
        }
    }

    //MARK Private

    private func mockSUT() {
        sut = TouchIDManagerFake()
        supportsMinVersion(true)
        sut.contextWrapper = TouchIDContextWrapperFake()
        canEvaluate(true)
        evaluatesFinger(true)
    }

    private func supportsMinVersion(_ supports:Bool) {
        (sut as! TouchIDManagerFake).supportsMinVersion = supports
    }

    private func canEvaluate(_ canEvaluate:Bool) {
        (sut.contextWrapper as! TouchIDContextWrapperFake).canEvaluate = canEvaluate
    }

    private func evaluatesFinger(_ success:Bool) {
        (sut.contextWrapper as! TouchIDContextWrapperFake).correctFinger = success
    }

}