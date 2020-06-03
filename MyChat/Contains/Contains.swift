//
//  Contant.swift
//  MyChat
//
//  Created by Chinh le on 5/28/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase

struct Contains {
    static var backgroundColorForPopup = UIColor.lightGray.withAlphaComponent(0.5)
    static let reference = Database.database().reference(withPath: "app-chat")
    static let users = Database.database().reference(withPath: "app-chat").child("users")
    static let message = Database.database().reference(withPath: "app-chat").child("messages")
}
