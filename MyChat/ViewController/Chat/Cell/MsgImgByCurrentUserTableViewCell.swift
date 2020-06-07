//
//  MsgImgByCurrentUserTableViewCell.swift
//  MyChat
//
//  Created by Chinh on 6/7/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class MsgImgByCurrentUserTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var msgImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
