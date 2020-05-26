//
//  IntroViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/26/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var stackViewBtn: UIStackView! /*  */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Action
    @IBAction func onclickLogin(_ sender: Any) {
        self.push(storyBoard: "Main", type: LoginViewController.self) { (destinationVC) in
            
        }
    }
    
    @IBAction func onclickRegister(_ sender: Any) {
        self.push(storyBoard: "Main", type: RegisterViewController.self) { (destinationVC) in
            
        }
    }
}
