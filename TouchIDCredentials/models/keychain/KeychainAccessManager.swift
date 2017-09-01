//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import Security
import Security.SecAccessControl
import Dispatch

class KeychainAccessManager: KeychainAccessProtocol {

    let serviceName = "passwordKey"
    let secItemWrapper : SecItemWrapperProtocol!

    init(secItemWrapper:SecItemWrapperProtocol) {
        self.secItemWrapper = secItemWrapper
    }

    func checkCredentials(userName:String) {

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

            switch status {
                case errSecSuccess:
                    print("success matching item from keychain")
                    break
                case errSecItemNotFound:
                    print("item not found in the keychain")
                    break
                default:
                    print("app couldn't find password")
                    break
            }
        }
    }


    func storeCredentials(userName: String, password: String) {
        var error: Unmanaged<CFError>?

        let sacObject = SecAccessControlCreateWithFlags(
                kCFAllocatorDefault,
                kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                SecAccessControlCreateFlags.userPresence,
                &error)

        let passwordData = password.data(using: .utf8)

        let attributes : [String: Any] = [
            String(kSecClass) : kSecClassGenericPassword,
            String(kSecAttrService) : serviceName,
            String(kSecAttrAccount) : userName,
            String(kSecValueData) : passwordData as Any,
            String(kSecAttrAccessControl) : sacObject as Any

        ]
        let status = secItemWrapper.addItem(attributes as CFDictionary, nil)

        switch status {
            case errSecSuccess:
                print("success saving password")
                break
            case errSecDuplicateItem:
                print("duplicated item in the keychain")
                break
            default:
                print("app couldn't save password")
                break
        }
    }

    func updateCredentials(userName:String, password:String) {

        let passwordData = password.data(using: .utf8)

        let query : [String:Any] = [
            String(kSecClass) : kSecClassGenericPassword,
            String(kSecAttrService) : serviceName,
            String(kSecAttrAccount) : userName,
        ]

        let attributes : [String: Any] = [
            String(kSecValueData) : passwordData as Any
        ]
        
        DispatchQueue.global(qos: .userInitiated).async {

            let status = self.secItemWrapper.updateItem(query as CFDictionary, attributes as CFDictionary)

            switch status {
            case errSecSuccess:
                print("success updating password")
                break
            case errSecDuplicateItem:
                print("duplicated item in the keychain, but I want to update it!")
                break
            case errSecItemNotFound:
                print("item not found in the keychain for updating")
                break
            default:
                print("app couldn't update password")
                break
            }
        }
    }

    func deleteCredentials(userName:String) {

        let query : [String:Any] = [
            String(kSecClass) : kSecClassGenericPassword,
            String(kSecAttrService) : serviceName,
            String(kSecAttrAccount) : userName,
        ]

        let status = secItemWrapper.deleteItem(query as CFDictionary)

        switch status {
            case errSecSuccess:
                print("success deleting user")
                break
            case errSecDuplicateItem:
                print("duplicated item in the keychain, but I want to delete it!")
                break
            case errSecItemNotFound:
                print("item not found in the keychain for deleting")
                break
            default:
                print("app couldn't delete password")
                break
        }

    }

}
