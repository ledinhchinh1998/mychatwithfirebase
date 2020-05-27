//
//  UITableViewExtension.swift
//  MyChat
//
//  Created by Chinh le on 5/27/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath, handle:((T) -> Void)) -> UITableViewCell {
        if let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T {
            handle(cell)
            return cell
        }
        
        return UITableViewCell()
    }
}
