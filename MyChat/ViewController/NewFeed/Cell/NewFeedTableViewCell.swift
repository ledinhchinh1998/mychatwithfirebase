//
//  NewFeedTableViewCell.swift
//  MyChat
//
//  Created by Chinh on 6/10/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class NewFeedTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var avtImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var countLikeLbl: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var shareLbl: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
