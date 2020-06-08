//
//  LastMessageModel.swift
//  MyChat
//
//  Created by Chinh le on 6/8/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import Foundation
import Firebase

class LastMessageModel {
    var lastMessage: String?
    var timeStamp: String?
    
    init?(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: AnyObject] {
            self.lastMessage = value["lastMessage"] as? String
            self.timeStamp = value["timeStamp"] as? String
        }
    }
}
