//
//  RegisterViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

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
    //MARK: Recycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad() 
        configNavigation()
        configView()
    }
    //MARK: Config
    private func configNavigation() {
        let navigationBar = navigationController?.navigationBar
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
        for textField in textFields {
            textField?.delegate = self
        }
    }
    //MARK: Action
    @IBAction func onclickRegister(_ sender: Any) {
        userModel = UserModel(firstNameTxt.text ?? "", lastNameTxt.text ?? "", userNameTxt.text ?? "", passwordTxt.text ?? "", emailTxt.text ?? "")
        showPopup()
    }
    //MARK: Function
    private func showPopup() {
        registrationResultPopup.view.frame = self.view.bounds
        registrationResultPopup.handle = { [weak self] in
            if let userModel = self?.userModel {
                self?.delegate?.passData(userModel: userModel)
            }
            
            self?.dismiss(animated: true, completion: nil)
        }
        
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

