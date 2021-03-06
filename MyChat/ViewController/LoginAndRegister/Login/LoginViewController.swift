//
//  LoginViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

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
    var userName: String?
    var userModel: ProfileModel?
    var isSecureTextField: Bool = true
    let togglePasswordBtn = UIButton(type: .custom)
    var loginResultsPopup = LoginResultsPopup()
    //MARK: Recycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewLayout()
        userNameTxt.clearButtonMode = .whileEditing
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController,
            let registerVC = navi.viewControllers.first as? RegisterViewController {
            registerVC.delegate = self
        }
        
        userNameTxt.text = nil
        passwordTxt.text = nil
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
        passwordTxt.isSecureTextEntry = true
        loginBtn.addShadowCustom(.zero, 5, 0.3)
        registerbtn.addShadowCustom(.zero, 5, 0.3)
        self.view.gradientColor(colors: colors)
        togglePasswordBtn.setImage(UIImage(named: "hide"), for: .normal)
        togglePasswordBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        togglePasswordBtn.addTarget(self, action: #selector(handleTogglePassword), for: .touchUpInside)
        passwordTxt.rightView = togglePasswordBtn
        passwordTxt.rightViewMode = .whileEditing
    }
    //MARK: Selector
    @objc private func handleTogglePassword() {
        if isSecureTextField {
            isSecureTextField = !isSecureTextField
            passwordTxt.isSecureTextEntry = false
            togglePasswordBtn.setImage(UIImage(named: "showPass"), for: .normal)
        } else {
            isSecureTextField = !isSecureTextField
            passwordTxt.isSecureTextEntry = true
            togglePasswordBtn.setImage(UIImage(named: "hide"), for: .normal)
        }
    }
    
    //MARK: Action
    @IBAction func onclickRegister(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.push(storyBoard: "Main", type: RegisterViewController.self) { (destinationVC) in
            destinationVC?.delegate = self
        }
    }
    
    @IBAction func onclickLogin(_ sender: Any) {
        if let userName = userNameTxt.text,
            let password = passwordTxt.text {
            SVProgressHUD.show()
            Auth.auth().signIn(withEmail: userName, password: password) { (result, error) in
                if error == nil {
                    SVProgressHUD.dismiss()
                    self.push(storyBoard: "MainTabbar", type: MainTabbarController.self) { (destinationVC) in
                        
                    }
                } else {
                    if let error = error as NSError? {
                        guard let errorCode = AuthErrorCode(rawValue: error.code) else {
                            print("------There was an error logging in but it could not be matched with a firebase code-----")
                            return
                        }
                        switch errorCode {
                        case .invalidEmail:
                            self.loginResultsPopup = LoginResultsPopup(frame: self.view.bounds)
                            self.loginResultsPopup.messageLbl.text = "Email invalid !!!"
                            self.view.addSubview(self.loginResultsPopup)
                        default:
                            print("Default")
                        }
                    }
                }
            }
        }
    }
}

extension LoginViewController: RegisterViewControllerProtocol {
    func passData(userModel: ProfileModel) {
        self.userModel = userModel
    }
}
