//
//  UsernameModel.swift
//  MyChat
//
//  Created by Chinh le on 5/28/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import Foundation
import Firebase

class UsernameModel {
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
