//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit
import XCTest

@testable import TouchIDCredentials

class KeychainAccessManagerTest: XCTestCase {

    var sut : KeychainAccessProtocol!

    override class func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testAddItemSuccess() {

    }

    func testStoreCredentials() {
        let secItemFake = SecItemWrapperFake()

        sut = KeychainAccessManagerFake(secItemWrapper: secItemFake)

        secItemFake.status = errSecSuccess
        var status = sut.storeCredentials(userName: "Miguel", password: "Miguel")
        XCTAssertTrue(status == errSecSuccess)

        secItemFake.status = errSecDuplicateItem
        status = sut.storeCredentials(userName: "Miguel", password: "Miguel")
        XCTAssertTrue(status == errSecDuplicateItem)
    }

    func testCheckCredentials() {
        let secItemFake = SecItemWrapperFake()

        sut = KeychainAccessManagerFake(secItemWrapper: secItemFake)

        secItemFake.status = errSecSuccess

//        (sut as! KeychainAccessManagerFake).asyncExpectation = expectation(description: "promise checkCredentials")
        let exp = expectation(description: "promise checkCredentials")

        
        sut.checkCredentials(userName: "Miguel").then {
            status -> Void in
            XCTAssertEqual(status, errSecSuccess)
            exp.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("fail expectation checkCredentials")
        }

        waitForExpectations(timeout: 5.0) {
            error in
            if error != nil {
                XCTFail("return after expect")
                return
            }
        }

    }


}
