//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import LocalAuthentication

@testable import TouchIDCredentials

class TouchIDContextWrapperFake: TouchIDContextProtocol {

    var canEvaluate = false

    func canEvaluatePolicy(_ policy: LocalAuthentication.LAPolicy, error: NSErrorPointer) -> Bool {
        return canEvaluate
    }

//    func evaluatePolicy(_ policy: LocalAuthentication.LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
////        context.evaluatePolicy(policy, localizedReason: localizedReason, reply: reply)
//    }

}
