//
// Created by MIGUEL MOLDES on 1/9/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit
import XCTest

@testable import TouchIDCredentials

class KeychainAccessManagerFake : KeychainAccessManager {

    let deferredPromise = Promise<OSStatus>.pending()
    var asyncExpectation : XCTestExpectation?

    override func checkCredentials(userName: String) -> Promise<OSStatus> {
//        if let expectation = asyncExpectation {
//            expectation.fulfill()
//        }
        deferredPromise.fulfill(0)
        return deferredPromise.promise
    }
}
