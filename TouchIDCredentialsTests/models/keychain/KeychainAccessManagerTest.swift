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

    let userName = "Underwood"
    let password = "Claire"

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testStoreCredentials() {
        sut = createSutWithStatus(errSecSuccess)

        var status = sut.storeCredentials(userName: userName, password: password)
        XCTAssertTrue(status == errSecSuccess)

        sut = createSutWithStatus(errSecDuplicateItem)
        status = sut.storeCredentials(userName: userName, password: password)
        XCTAssertTrue(status == errSecDuplicateItem)

        let anyError:Int32 = 99009999
        sut = createSutWithStatus(anyError)
        status = sut.storeCredentials(userName: userName, password: password)
        XCTAssertTrue(status == anyError)
    }

    func testCheckCredentialsSuccess() {
        sut = createSutWithStatus(errSecSuccess)

        let exp = expectation(description: "promise checkCredentials")

        sut.checkCredentials(userName: userName).then {
            status -> Void in
            XCTAssertEqual(status, errSecSuccess)
            exp.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("fail expectation checkCredentials")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("return after expect")
                return
            }
        }
    }

    func testCheckCredentialsNotFound() {
        sut = createSutWithStatus(errSecItemNotFound)

        let exp = expectation(description: "promise checkCredentials")

        sut.checkCredentials(userName: "AnyUserName").then {
            status -> Void in
            XCTAssertEqual(status, errSecItemNotFound)
            exp.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("fail expectation checkCredentials")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("return after expect")
                return
            }
        }
    }

    func testCheckCredentialsAnyError() {
        let anyError:Int32 = 99009900
        sut = createSutWithStatus(anyError)

        let exp = expectation(description: "promise checkCredentials")

        sut.checkCredentials(userName: userName).then {
            status -> Void in
            XCTAssertEqual(status, anyError)
            exp.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("fail expectation checkCredentials")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("return after expect")
                return
            }
        }
    }

    func testUpdatingCredentialsSuccessful() {
        sut = createSutWithStatus(errSecSuccess)

        let exp = expectation(description: "promise updateCredentials")

        sut.updateCredentials(userName: userName, password: "123").then {
            status -> Void in
            XCTAssertEqual(status, errSecSuccess)
            exp.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("fail expectation updateCredentials")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("return after expect")
                return
            }
        }
    }

    func testUpdatingCredentialsNotFound() {
        sut = createSutWithStatus(errSecItemNotFound)

        let exp = expectation(description: "promise updateCredentials")

        sut.updateCredentials(userName: userName, password: "123").then {
            status -> Void in
            XCTAssertEqual(status, errSecItemNotFound)
            exp.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("fail expectation updateCredentials")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("return after expect")
                return
            }
        }
    }

    func testUpdatingCredentialsAnyError() {
        let anyError:Int32 = 99009900
        sut = createSutWithStatus(anyError)

        let exp = expectation(description: "promise updateCredentials")

        sut.updateCredentials(userName: userName, password: "123").then {
            status -> Void in
            XCTAssertEqual(status, anyError)
            exp.fulfill()
        }.catch(policy:.allErrors) {
            error in
            XCTFail("fail expectation updateCredentials")
        }

        waitForExpectations(timeout: 1.0) {
            error in
            if error != nil {
                XCTFail("return after expect")
                return
            }
        }
    }

    func testDeleteCredentials() {
        sut = createSutWithStatus(errSecSuccess)
        var status = sut.deleteCredentials(userName: userName)
        XCTAssertTrue(status == errSecSuccess)

        sut = createSutWithStatus(errSecDuplicateItem)
        status = sut.deleteCredentials(userName: userName)
        XCTAssertTrue(status == errSecDuplicateItem)

        let anyError:Int32 = 99009999
        sut = createSutWithStatus(anyError)
        status = sut.deleteCredentials(userName: userName)
        XCTAssertTrue(status == anyError)
    }


    // MARK Private

    private func createSutWithStatus(_ status:OSStatus) -> KeychainAccessProtocol {
        let secItemFake = SecItemWrapperFake()
        secItemFake.status = status
        return(KeychainAccessManager(secItemWrapper: secItemFake))
    }

}