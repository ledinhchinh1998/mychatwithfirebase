//
//  LoginViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1), UIColor(red: 255/255, green: 195/255, blue: 160/255, alpha: 1)]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
