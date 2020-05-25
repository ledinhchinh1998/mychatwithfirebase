//
//  UserModel.swift
//  MyChat
//
//  Created by Chinh le on 5/25/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import Foundation

struct UserModel {
    var firstName: String?
    var lastName: String?
    var userName: String?
    var password: String?
    var email: String?
    
    init(_ firstName: String?,_ lastName: String?,_ userName: String?,_ password: String?,_ email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.password = password
        self.email = email
    }
}
