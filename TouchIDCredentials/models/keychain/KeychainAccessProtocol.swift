//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

protocol KeychainAccessProtocol {

    func storeCredentials(userName:String, password:String)

    func checkCredentials(userName:String)

    func updateCredentials(userName:String, password:String)

    func deleteCredentials(userName:String)

}
