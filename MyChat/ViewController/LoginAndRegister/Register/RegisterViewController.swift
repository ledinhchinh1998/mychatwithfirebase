//
//  RegisterViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: Outlet
    
    //MARK: Property
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
    }
    //MARK: Config
    private func configLayout() {
        let colors = [UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 195/255, blue: 160/255, alpha: 1).cgColor]
        let navigationBar = navigationController?.navigationBar
        navigationBar?.gradientColor(colors: colors)
//        navigationBar?.tintColor = UIColor.white
        navigationController?.navigationItem.title = "Register"
    }
}
