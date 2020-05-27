//
//  UICollectionViewExtension.swift
//  MyChat
//
//  Created by Chinh le on 5/27/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReuseableCell<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath, handle:((T) -> Void)) -> UICollectionViewCell {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T {
            handle(cell)
            return cell
        }
        
        return UICollectionViewCell()
    }
}
