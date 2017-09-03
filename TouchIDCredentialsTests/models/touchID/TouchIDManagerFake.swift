//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import XCTest
import PromiseKit
import LocalAuthentication

@testable import TouchIDCredentials

class TouchIDManagerFake: TouchIDManager {

    var success : Bool = false
    var supportsMinVersion : Bool = true
    var canEvaluate : Bool = true
    var evaluatesSuccessfully : Bool = true

    /*override func checkID() -> Promise<Bool> {
        return Promise<Bool>{
            fulfill, reject in
            if success {
                fulfill(true)
                return
            }
            fulfill(false)
        }
    }*/

    /*override func checkID() -> Promise<Bool> {
        return Promise<Bool> {
            fulfill, reject in

        }
    }*/

    override func minimumVersion() -> Bool {
        return supportsMinVersion
    }
}
