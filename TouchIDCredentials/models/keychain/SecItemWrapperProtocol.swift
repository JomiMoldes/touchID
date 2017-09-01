//
// Created by MIGUEL MOLDES on 1/9/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

protocol SecItemWrapperProtocol {

    func addItem(_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus

    func updateItem(_ query: CFDictionary, _ attributesToUpdate: CFDictionary) -> OSStatus

    func deleteItem(_ query: CFDictionary) -> OSStatus

    func itemCopyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus

}
