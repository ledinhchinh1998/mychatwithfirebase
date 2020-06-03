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
    var email: String?
    var avatarImgUrl: String?
    var firstName: String?
    var lastName: String?
    var userName: String?
    var password: String?
    var id: String?
    
    init(_ firstName: String?,_ lastName: String?,_ userName: String?,_ password: String?,_ email: String?, id: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.password = password
        self.email = email
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: AnyObject] {
            self.email = value["email"] as? String
            self.lastName = value["lastName"] as? String
            self.firstName = value["firstName"] as? String
            self.password = value["password"] as? String
            self.avatarImgUrl = value["avatarImgUrl"] as? String
            self.userName = value["userName"] as? String
        }
    }
}
