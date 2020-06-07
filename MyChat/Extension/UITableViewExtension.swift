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
    
    func scrollToBottom(animated: Bool = false) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {

                self.scrollToRow(at: IndexPath(row: row-1, section: section-1), at: .bottom, animated: animated)
            }
        }
    }
}
