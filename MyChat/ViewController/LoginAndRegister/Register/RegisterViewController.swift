//
//  RegisterViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

protocol RegisterViewControllerProtocol {
    func passData()
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
    //MARK: Property
    typealias Popup = RegistrationResultsPopup
    typealias Delegate = RegisterViewControllerProtocol
    private var registrationResultPopup = Popup(nibName: Popup.className, bundle: nil)
    private var userModel: UserModel?
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
    }
    //MARK: Action
    @IBAction func onclickRegister(_ sender: Any) {
        if validation(testStr: firstNameTxt.text ?? "") {
            print("Oke")
        } else {
            validateFirstNameLbl.isHidden = false
        }
    }
    //MARK: Function
    private func showPopup() {
        registrationResultPopup.view.frame = self.view.bounds
        registrationResultPopup.handle = { [weak self] in
            
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
    
    private func validation(testStr: String) -> Bool {
        guard testStr.count > 0 && testStr.count < 18 else {
            return false
        }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
}

