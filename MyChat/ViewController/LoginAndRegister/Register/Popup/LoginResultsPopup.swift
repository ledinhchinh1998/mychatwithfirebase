//
//  LoginResultsPopup.swift
//  MyChat
//
//  Created by Chinh le on 5/28/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class LoginResultsPopup: UIView {
    
    //MARK: Outlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    //MARK: Property
    var handle: VoidClosure?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Action
    @IBAction func done(_ sender: Any) {
        
    }
}
