//
//  MessageTableViewCell.swift
//  MyChat
//
//  Created by Chinh on 5/31/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var messageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
