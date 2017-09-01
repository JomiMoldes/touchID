//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

protocol KeychainAccessProtocol {

    func storeCredentials(userName:String, password:String) -> OSStatus

    func checkCredentials(userName:String) -> Promise<OSStatus>

    func updateCredentials(userName:String, password:String)// -> Promise<OSStatus>

    func deleteCredentials(userName:String)

}
