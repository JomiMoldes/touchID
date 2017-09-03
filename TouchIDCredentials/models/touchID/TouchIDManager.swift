//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import LocalAuthentication
import PromiseKit

class TouchIDManager: TouchIDProtocol {

    var contextWrapper: TouchIDContextProtocol = TouchIDContextWrapper()

    func checkID() -> Promise<Bool> {
        return Promise<Bool> {
            fulfill, reject in

            shouldShowTouchIDButton().then {
                success -> Void in
                if success {
                    var authError: NSError? = nil
                    self.evaluatePolicy(authError: &authError) {
                        (success, evaluateError) in
                        if success {
                            fulfill(true)
                            return
                        }
                        reject(evaluateError!)
                    }
                    return
                }
                fulfill(false)
            }.catch(policy: .allErrors) {
                error in
                reject(error)
            }
        }
    }

    func shouldShowTouchIDButton() -> Promise<Bool> {
        return Promise<Bool> {
            fulfill, reject in
            guard minimumVersion() else {
                return fulfill(false)
            }
            var authError: NSError? = nil
            if canEvaluatePolicy(authError: &authError) {
                fulfill(true)
                return
            }
            reject(authError!)
        }
    }

    func minimumVersion() -> Bool {
        if #available(iOS 8.0, *) {
            return true
        }
        return false
    }

    //MARK Private

    private func canEvaluatePolicy(authError:NSErrorPointer) -> Bool {
        return contextWrapper.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: authError)
//        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: authError)
    }

    private func evaluatePolicy(authError:NSErrorPointer, reply: @escaping (Bool, Error?) -> Swift.Void) {
        let myLocalizedReasonString = "Use your finger please"
        return contextWrapper.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString, reply: reply)
    }

}