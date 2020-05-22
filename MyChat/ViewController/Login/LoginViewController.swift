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
    //MARK: Property
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 195/255, blue: 160/255, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        configLayout()
    }
    
    //MARK: Config
    private func configLayout() {
        btnFacebook.addShadowDistanceBottom(5, 0.5, 10, 5)
        btnTwitter.addShadowDistanceBottom(5, 0.5, 10, 5)
        btnGoogle.addShadowDistanceBottom(5, 0.5, 10, 5)
        btnApple.addShadowDistanceBottom(5, 0.5, 10, 5)
    }

}
