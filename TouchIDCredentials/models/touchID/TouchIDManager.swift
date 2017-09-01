//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import LocalAuthentication

class TouchIDManager: TouchIDProtocol {

    var context : TouchIDContextProtocol = TouchIDContextWrapper()

    func checkID(completion:@escaping (Bool) -> Void) {
        let myLocalizedReasonString = "Use your finger please"

        var authError: NSError? = nil
        if shouldShowTouchIDButton() {
            if canEvaluatePolicy(authError: &authError) {
                (context as! TouchIDContextWrapper).context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { (success, evaluateError) in
                    if (success) {
//                        print("correct finger")
//                        // User authenticated successfully, take appropriate action
                        completion(true)
                    } else {
                        if let error = evaluateError {
                            switch (error as NSError).code {
                            case LAError.userCancel.rawValue:
                                print("user cancel")
                                break
                            case LAError.systemCancel.rawValue:
                                print("system cancel")
                                break
                            case LAError.userFallback.rawValue:
                                print("user fallback")
                                break
                            default:
                            break
                            }
                            completion(false)
                        }

                    }
                }
            } else {
//                // Could not evaluate policy; look at authError and present an appropriate message to user
                completion(false)
            }
        } else {
            // Fallback on earlier versions
            completion(false)
        }
        
    }

    func shouldShowTouchIDButton() -> Bool {
        if !minimumVersion() {
            return false
        }
        return true
    }

    func canEvaluatePolicy(authError:NSErrorPointer) -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: authError)
    }

    func minimumVersion() -> Bool {
        if #available(iOS 8.0, *) {
            return true
        }
        return false
    }

}
