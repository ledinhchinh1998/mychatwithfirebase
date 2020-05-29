//
//  UserModel.swift
//  MyChat
//
//  Created by Chinh le on 5/28/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import Foundation
import Firebase

class UserModel: NSObject {
    var name: String?
    var email: String?
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let email = value["email"] as? String else {
                return nil
        }
        
        self.name = name
        self.email = email
    }
}
