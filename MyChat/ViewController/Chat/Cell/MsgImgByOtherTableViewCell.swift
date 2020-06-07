//
//  MsgImgByOtherTableViewCell.swift
//  MyChat
//
//  Created by Chinh on 6/7/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class MsgImgByOtherTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var msgImg: UIImageView!
    @IBOutlet weak var avtImg: UIImageView!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
