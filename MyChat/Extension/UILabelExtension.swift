//
//  UILabelExtension.swift
//  MyChat
//
//  Created by Chinh le on 5/29/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

extension UILabel {
    func embedLeftIcon(icon: String, textString: String) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: icon)
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: textString)
        completeText.append(textAfterIcon)
        self.textAlignment = .center
        self.attributedText = completeText
    }
}
