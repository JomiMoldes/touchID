//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import LocalAuthentication

class TouchIDContextWrapper: TouchIDContextProtocol {

    var context = LAContext()

    func canEvaluatePolicy(_ policy: LocalAuthentication.LAPolicy, error: NSErrorPointer) -> Bool {
        return context.canEvaluatePolicy(policy, error: error)
    }

    func evaluatePolicy(_ policy: LocalAuthentication.LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        context.evaluatePolicy(policy, localizedReason: localizedReason, reply: reply)
    }
}
