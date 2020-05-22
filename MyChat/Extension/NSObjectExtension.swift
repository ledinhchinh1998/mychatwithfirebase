//
//  NSObject.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import Foundation
extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
