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
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    //MARK: Property
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
    }
    //MARK: Config
    private func configLayout() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar?.barTintColor = UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1)
        navigationItem.title = "Resiter"        
    }
}
