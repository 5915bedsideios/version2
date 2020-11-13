//
//  Global.swift
//  BedSide Chats
//
//  Created by Jack Wu on 11/14/20.
//

import Foundation

struct Global {
    static var USER_INFO: User? = nil
}

protocol Action {
    func onAction() -> Void
}
import Foundation
