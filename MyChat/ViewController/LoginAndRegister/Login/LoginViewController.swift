//
//  LoginViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    //MARK: Property
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewLayout()
    }
    
    //MARK: Config
    private func configViewLayout() {
        btnFacebook.addShadowDistanceBottom(5, 0.5, 10, 5)
        btnTwitter.addShadowDistanceBottom(5, 0.5, 10, 5)
        btnGoogle.addShadowDistanceBottom(5, 0.5, 10, 5)
        btnApple.addShadowDistanceBottom(5, 0.5, 10, 5)
        let colors = [UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 195/255, blue: 160/255, alpha: 1).cgColor]
        loginLbl.addShadowDistanceBottom(5, 0.6, 0, 3)
        titleLbl.addShadowDistanceBottom(5, 0.6, 0, 3)
        userNameTxt.addShadowCustom(.zero, 5, 0.3)
        passwordTxt.addShadowCustom(.zero, 5, 0.3)
        loginBtn.addShadowCustom(.zero, 5, 0.3)
        registerbtn.addShadowCustom(.zero, 5, 0.3)
        self.view.gradientColor(colors: colors)
    }

}
