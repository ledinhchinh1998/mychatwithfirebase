//
//  ChatTableViewCell.swift
//  MyChat
//
//  Created by Chinh le on 5/27/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var avtImage: UIImageView!
    @IBOutlet weak var nameUserLbl: UILabel!
    @IBOutlet weak var lastMessageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
