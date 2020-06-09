//
//  ProfileDetailTableViewCell.swift
//  MyChat
//
//  Created by Chinh le on 6/9/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class ProfileDetailTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var btn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func handle(_ sender: Any) {
        
    }
    
}
