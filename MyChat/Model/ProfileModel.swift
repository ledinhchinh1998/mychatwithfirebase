//
//  UserModel.swift
//  MyChat
//
//  Created by Chinh le on 5/25/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import Foundation
import Firebase

struct ProfileModel {
    
    let ref: DatabaseReference?
    let key: String?
    var firstName: String?
    var lastName: String?
    var userName: String?
    var password: String?
    var email: String?
    
    init(_ firstName: String?,_ lastName: String?,_ userName: String?,_ password: String?,_ email: String?,_ key: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.password = password
        self.email = email
        self.key = key
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let userName = value["userName"] as? String,
            let password = value["password"] as? String,
            let email = value["email"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.email = email
        self.password = password
    }
    
    func toAnyObject() -> Any {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "userName": userName,
            "email": email
        ]
    }
}
