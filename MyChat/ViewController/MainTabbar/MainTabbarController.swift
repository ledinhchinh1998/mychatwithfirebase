//
//  MainTabbarController.swift
//  MyChat
//
//  Created by Chinh le on 5/27/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase

class MainTabbarController: UITabBarController {
    
    //MARK: Property
    var user: User?
    
    let arrImg = [UIImage(named: "ic-message"), UIImage(named: "newspaper"), UIImage(named: "ic-friends"), UIImage(named: "ic-profile")]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrImg[i]
                let imageNameForUnselectedState = arrImg[i]

                self.tabBar.items?[i].selectedImage = imageNameForSelectedState?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = imageNameForUnselectedState?.withRenderingMode(.alwaysOriginal)
            }
        }

        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }
}
