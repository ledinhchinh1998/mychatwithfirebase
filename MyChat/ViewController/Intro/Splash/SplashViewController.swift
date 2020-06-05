//
//  SplashViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/26/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        animatedSplash()
    }
    
    //MARK: Config
    private func configLayout() {
        let colors = [UIColor(red: 255/255, green: 175/255, blue: 189/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 195/255, blue: 160/255, alpha: 1).cgColor]
        self.view.gradientColor(colors: colors)
    }
    
    //MARK: Function
    private func animatedSplash() {
        UIView.animate(withDuration: 2, delay: 0, animations: {
            self.img.transform = CGAffineTransform(translationX: 0, y: 15)
            self.lbl.transform = CGAffineTransform(translationX: 0, y: -15)
        }) { (completion) in
//            if let decoded = UserDefaults.standard.object(forKey: "User") as? Data {
//                do {
//                    let user = try NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User
//                    Contains.users.child(user.uid).observe(.value) { (snapshot) in
//                        let currentUser = UserModel(snapshot: snapshot)
//                        Auth.auth().signIn(withEmail: currentUser?.email ?? "", password: currentUser?.password ?? "") { (result, err) in
//                            self.push(storyBoard: "MainTabbar", type: MainTabbarController.self) { _ in
//
//                            }
//                        }
//                    }
//                } catch {
//                    print("Unarchived Object is failed")
//                }
//            } else {
//
//            }
            self.push(storyBoard: "Intro", type: RootPageViewController.self) { (destinationVC) in
                
            }
        }
    }

}
