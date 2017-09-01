//
// Created by MIGUEL MOLDES on 1/9/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import Security.SecAccessControl

class SecItemWrapper : SecItemWrapperProtocol {

    func addItem(_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return SecItemAdd(attributes, result)
    }

    func updateItem(_ query: CFDictionary, _ attributesToUpdate: CFDictionary) -> OSStatus {
        return SecItemUpdate(query, attributesToUpdate)
    }

    func deleteItem(_ query: CFDictionary) -> OSStatus {
        return SecItemDelete(query)
    }

    func itemCopyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return SecItemCopyMatching(query, result)
    }

}
