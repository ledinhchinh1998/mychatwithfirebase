//
//  RegistrationResultsPopup.swift
//  MyChat
//
//  Created by Chinh le on 5/25/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
typealias VoidClosure = (() -> Void)
class RegistrationResultsPopup: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var done: UIButton!
    //MARK: Property
    var handle: VoidClosure?
    //MARK: Recycle Viewcontroller
    override func viewDidLoad() {
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    //MARK: Action
    @IBAction func done(_ sender: Any) {
        handle?()
    }
}


