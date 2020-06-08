//
//  Ultities.swift
//  MyChat
//
//  Created by Chinh le on 6/8/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import Foundation
import UIKit

class Ultities {
    static var shared: Ultities = {
        return Ultities.init()
    }()
    
    private init() {}
    
    func timeIntervalToDateString(withInterval string: String) -> String {
        let timeInterval: TimeInterval = (string as NSString).doubleValue
        let dateFromServer = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let string = String(dateFormater.string(from: dateFromServer as Date))
        return string
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
