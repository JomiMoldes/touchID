//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol TouchIDContextProtocol {

    func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool

//    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Swift.Void)

}
