//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import XCTest
import LocalAuthentication

@testable import TouchIDCredentials

class TouchIDManagerFake: TouchIDManager {

    var success : Bool = false
    var supportsMinVersion : Bool = true

    override func checkID(completion:@escaping (Bool) -> Void) {
        if shouldShowTouchIDButton() {
            if canEvaluatePolicy(authError: nil) {
                completion(true)
                return
            }
        }
        completion(false)
    }

    override func minimumVersion() -> Bool {
        return supportsMinVersion
    }
}
