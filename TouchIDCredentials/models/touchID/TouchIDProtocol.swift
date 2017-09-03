//
// Created by MIGUEL MOLDES on 31/8/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

protocol TouchIDProtocol {

    var contextWrapper: TouchIDContextProtocol { get set }

    func checkID() -> Promise<Bool>

    func shouldShowTouchIDButton() -> Promise<Bool>

}
