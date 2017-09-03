//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import Security
import PromiseKit
import Security.SecAccessControl


class KeychainAccessManager: KeychainAccessProtocol {

    let serviceName = "passwordKey"
    let secItemWrapper : SecItemWrapperProtocol!

    init(secItemWrapper:SecItemWrapperProtocol) {
        self.secItemWrapper = secItemWrapper
    }

    func checkCredentials(userName:String) -> Promise<OSStatus> {
        return Promise<OSStatus> {
            fulfill, reject in
            let query : [String:Any] = [
                String(kSecClass) : kSecClassGenericPassword,
                String(kSecAttrService) : serviceName,
                String(kSecAttrAccount) : userName,
                String(kSecReturnData) : true,
                String(kSecUseOperationPrompt) : "Authenticate to login"
            ]

            DispatchQueue.global(qos: .userInitiated).async{
                var result : CFTypeRef?
                let status = self.secItemWrapper.itemCopyMatching(query as CFDictionary, &result)
                fulfill(status)
            }
        }
    }


    func storeCredentials(userName: String, password: String) -> OSStatus {
        var error: Unmanaged<CFError>?

        let sacObject = SecAccessControlCreateWithFlags(
                kCFAllocatorDefault,
                kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                SecAccessControlCreateFlags.userPresence,
                &error)

        let passwordData = password.data(using: .utf8)

        let attributes: [String: Any] = [
            String(kSecClass): kSecClassGenericPassword,
            String(kSecAttrService): serviceName,
            String(kSecAttrAccount): userName,
            String(kSecValueData): passwordData as Any,
            String(kSecAttrAccessControl): sacObject as Any

        ]
        return secItemWrapper.addItem(attributes as CFDictionary, nil)
    }

    func updateCredentials(userName:String, password:String) -> Promise<OSStatus> {
        return Promise<OSStatus> {
            fulfill, reject in

            let passwordData = password.data(using: .utf8)

            let query: [String: Any] = [
                String(kSecClass): kSecClassGenericPassword,
                String(kSecAttrService): serviceName,
                String(kSecAttrAccount): userName,
            ]

            let attributes: [String: Any] = [
                String(kSecValueData): passwordData as Any
            ]

            DispatchQueue.global(qos: .userInitiated).async {
                fulfill(self.secItemWrapper.updateItem(query as CFDictionary, attributes as CFDictionary))
            }
        }
    }

    func deleteCredentials(userName:String) -> OSStatus {

        let query : [String:Any] = [
            String(kSecClass) : kSecClassGenericPassword,
            String(kSecAttrService) : serviceName,
            String(kSecAttrAccount) : userName,
        ]

        return(secItemWrapper.deleteItem(query as CFDictionary))
    }

}
