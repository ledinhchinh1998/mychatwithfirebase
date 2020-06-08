//
//  StringExtension.swift
//  MyChat
//
//  Created by Chinh le on 6/8/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

extension String {
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter {
            !forbiddenChars.contains($0)
        }
        
        return String(String.UnicodeScalarView(passed))
    }

    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}
