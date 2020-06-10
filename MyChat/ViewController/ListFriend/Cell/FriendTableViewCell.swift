//
//  FriendTableViewCell.swift
//  MyChat
//
//  Created by Chinh le on 6/10/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var avtImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
