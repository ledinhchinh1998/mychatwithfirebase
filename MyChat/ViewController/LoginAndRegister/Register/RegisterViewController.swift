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
    @IBOutlet weak var registerLbl: UILabel!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    //MARK: Property
    override func viewDidLoad() {
        super.viewDidLoad() 
//        configNavigation()
//        configView()
//        registerLbl.layer.shadowRadius = 0
//        registerLbl.layer.shadowOffset = .zero
//        registerLbl.layer.shadowOpacity = 0.2
//
//        // how far the bottom of the shadow should be offset
//        let shadowOffsetX: CGFloat = 2000
//        let shadowPath = UIBezierPath()
//        let width = registerLbl.bounds.width
//        let height = registerLbl.bounds.height
//        registerLbl.layer.masksToBounds = false
//        shadowPath.move(to: CGPoint(x: 0, y: height))
//        shadowPath.addLine(to: CGPoint(x: width, y: 0))
//        shadowPath.addLine(to: CGPoint(x: width + shadowOffsetX, y: 2000))
//        shadowPath.addLine(to: CGPoint(x: shadowOffsetX, y: 2000))
//        registerLbl.layer.shadowOpacity = 1
//        registerLbl.layer.shadowPath = shadowPath.cgPath
    }
    //MARK: Config
//    private func configNavigation() {
//        let navigationBar = navigationController?.navigationBar
//        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationBar?.barTintColor = UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1)
//        navigationItem.title = "Resiter"
//    }
//    
//    private func configView() {
//        let colors = [UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 195/255, blue: 160/255, alpha: 1).cgColor]
//        self.view.gradientColor(colors: colors)
//        firstNameTxt.addShadowCustom(.zero, 5, 0.3)
//        lastNameTxt.addShadowCustom(.zero, 5, 0.3)
//        passwordTxt.addShadowCustom(.zero, 5, 0.3)
//        confirmPasswordTxt.addShadowCustom(.zero, 5, 0.3)
//        registerBtn.addShadowCustom(.zero, 5, 0.3)
//    }
    //MARK: Action
    @IBAction func onclickRegister(_ sender: Any) {
        
    }
}
