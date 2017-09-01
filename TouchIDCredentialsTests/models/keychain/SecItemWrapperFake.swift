//
// Created by MIGUEL MOLDES on 1/9/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

@testable import TouchIDCredentials

class SecItemWrapperFake : SecItemWrapper {

    var status : OSStatus!
    
    override func addItem(_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return status
    }
}
