//
//  MessageModel.swift
//  MyChat
//
//  Created by Chinh on 5/31/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase

class MessageModel {
    var fromId: String?
    var toId: String?
    var text: String?
    var timeStamp: String?
    var sender: String?
    var image: String?
    
    init(_ fromId: String?,_ toId: String?,_ text: String?,_ timeStamp: String?) {
        self.fromId = fromId
        self.toId = toId
        self.text = text
        self.timeStamp = timeStamp
    }
    
    init?(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: AnyObject] {
            self.fromId = value["fromID"] as? String
            self.toId = value["toID"] as? String
            self.text = value["text"] as? String
            self.timeStamp = value["timeStamp"] as? String
            self.sender = value["sender"] as? String
            self.image = value["image"] as? String
        }
    }
}
