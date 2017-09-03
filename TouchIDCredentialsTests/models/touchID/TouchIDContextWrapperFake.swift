//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import LocalAuthentication

@testable import TouchIDCredentials

class TouchIDContextWrapperFake: TouchIDContextProtocol {

    var context = LAContext()

    var canEvaluate = true
    var correctFinger = true

    func canEvaluatePolicy(_ policy: LocalAuthentication.LAPolicy, error: NSErrorPointer) -> Bool {
        if error != nil {
            error?.pointee = NSError(domain: "", code: 1)
        }
        return canEvaluate
    }

    func evaluatePolicy(_ policy: LocalAuthentication.LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        if correctFinger {
            reply(true, nil)
            return
        }
        reply(false, NSError(domain: "", code: 1))
    }

}
