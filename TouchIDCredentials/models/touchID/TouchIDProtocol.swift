//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

protocol TouchIDProtocol {

    var context : TouchIDContextProtocol { get set }

    func checkID(completion:@escaping (Bool) -> Void)

    func shouldShowTouchIDButton() -> Bool

}
