//
//  MessageTableViewCell.swift
//  MyChat
//
//  Created by Chinh on 5/31/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class MessageByOtherTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var heightTimeStamp: NSLayoutConstraint!
    @IBOutlet weak var avatarImg: UIImageView!
    
    //MARK: Property
    var handleReloadRow: ((CGFloat) -> Void)?
    var isToggleTimeStamp = true
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        _ = UITapGestureRecognizer(target: self, action: #selector(toggleTimeStamp))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: Function
    func isCurrentUser(check: Bool) {
        
    }
    
    //MARK: Selector
    @objc func toggleTimeStamp() {
        if isToggleTimeStamp {
            isToggleTimeStamp = !isToggleTimeStamp
        } else {
            isToggleTimeStamp = !isToggleTimeStamp
        }
    }
    
}
