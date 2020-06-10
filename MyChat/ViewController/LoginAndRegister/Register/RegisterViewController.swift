//
//  RegisterViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

protocol RegisterViewControllerProtocol {
    func passData(userModel: UserModel)
}

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
    @IBOutlet weak var validateFirstNameLbl: UILabel!
    @IBOutlet weak var validateLastNameLbl: UILabel!
    @IBOutlet weak var validateUsernameLbl: UILabel!
    @IBOutlet weak var validatePasswordLbl: UILabel!
    @IBOutlet weak var validateConfirmPasswordLbl: UILabel!
    @IBOutlet weak var validateEmailLbl: UILabel!
    
    //MARK: Property
    typealias Popup = RegistrationResultsPopup
    typealias Delegate = RegisterViewControllerProtocol
    private var registrationResultPopup = Popup(nibName: Popup.className, bundle: nil)
    private var userModel: UserModel?
    lazy var textFields = [self.firstNameTxt, self.lastNameTxt, self.passwordTxt, self.emailTxt, self.confirmPasswordTxt]
    var delegate: Delegate?
    var ref = Database.database().reference(withPath: "app-chat")
    
    //MARK: Recycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad() 
        configNavigation()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    //MARK: Config
    private func configNavigation() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar?.barTintColor = UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1)
        navigationItem.title = "Resiter"
    }
    
    private func configView() {
        let colors = [UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 195/255, blue: 160/255, alpha: 1).cgColor]
        self.view.gradientColor(colors: colors)
        firstNameTxt.addShadowCustom(.zero, 5, 0.3)
        lastNameTxt.addShadowCustom(.zero, 5, 0.3)
        passwordTxt.addShadowCustom(.zero, 5, 0.3)
        confirmPasswordTxt.addShadowCustom(.zero, 5, 0.3)
        emailTxt.addShadowCustom(.zero, 5, 0.3)
        userNameTxt.addShadowCustom(.zero, 5, 0.3)
        registerBtn.addShadowCustom(.zero, 5, 0.3)
        registerLbl.addShadowDistanceBottom(5, 0.6, 0, 3)
        passwordTxt.isSecureTextEntry = true
        confirmPasswordTxt.isSecureTextEntry = true
        for textField in textFields {
            textField?.delegate = self
        }
    }
    
    //MARK: Action
    @IBAction func onclickRegister(_ sender: Any) {
        let firstName = firstNameTxt.text ?? ""
        let lastName = lastNameTxt.text ?? ""
        let userName = userNameTxt.text ?? ""
        let password = passwordTxt.text ?? ""
        let email = emailTxt.text
        userModel = UserModel(firstName, lastName, userName, password, email, id: nil)
        if let userModel = self.userModel,
            let email = userModel.email,
            let password = userModel.password,
            let userName = userModel.userName {
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    if let uid = result?.user.uid {
                        let usersRefer = Contains.users.child(uid)
                        let values = [
                            "firstName": firstName,
                            "lastName": lastName,
                            "userName": userName,
                            "password": password,
                            "email": email,
                        ]
                        
                        usersRefer.updateChildValues(values) { (err, ref) in
                            if err == nil {
                                print("Saved user successfully into firebase db")
                            } else {
                                print("Update child values user is failed")
                            }
                        }
                    }
                    self.showPopup(registerSuccess: true)
                } else {
                    self.showPopup(registerSuccess: false)
                }
            }
        }
    }
    
    //MARK: Function
    private func showPopup(registerSuccess: Bool) {
        registrationResultPopup.view.frame = self.view.bounds
        if registerSuccess {
            self.registrationResultPopup.messageLbl.text = "Check your email for chat confirmation. We'll  see you soon!"
            self.registrationResultPopup.titleLbl.text = "Success"
            self.registrationResultPopup.checkImg.image = UIImage(named: "check")
            registrationResultPopup.handle = { [weak self] in
                self?.registrationResultPopup.view.removeFromSuperview()
                self?.navigationController?.popViewController(animated: true)
            }
            
        } else {
            self.registrationResultPopup.checkImg.image = UIImage(named: "error")
            self.registrationResultPopup.messageLbl.text = "The register could not be made. Try again!"
            self.registrationResultPopup.titleLbl.text = "Failed"
            self.registrationResultPopup.view.removeFromSuperview()
            registrationResultPopup.handle = { [weak self] in
                self?.registrationResultPopup.view.removeFromSuperview()
            }
        }
        
        SVProgressHUD.dismiss()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0, options: [], animations: {
            self.registrationResultPopup.view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.registrationResultPopup.view.transform = .identity
            self.view.addSubview(self.registrationResultPopup.view)
        }) { (completion) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.registrationResultPopup.checkImg.transform = CGAffineTransform(rotationAngle: .pi)
                self.registrationResultPopup.checkImg.transform = .identity
                self.registrationResultPopup.checkImg.isHidden = false
            }, completion: nil)
        }
    }
    
    // Validate form
    private func validation(testStr: String) -> Bool {
        guard testStr.count > 0 && testStr.count < 18 else {
            return false
        }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
//MARK: TextField
extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

