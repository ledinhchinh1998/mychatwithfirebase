//
//  UIViewControllerExtension.swift
//  MyChat
//
//  Created by Chinh le on 5/26/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

extension UIViewController {
    func push<T: UIViewController>(storyBoard: String?, type: T.Type, bundle: Bundle? = nil, handle: ((T?) -> Void)) {
        if let storyBoard = storyBoard {
            if let viewController = UIStoryboard(name: storyBoard, bundle: bundle).instantiateViewController(identifier: T.className) as? T {
                handle(viewController)
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                let viewController = T(nibName: T.className, bundle: bundle)
                handle(viewController)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}
