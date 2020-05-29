//
//  ViewCustom.swift
//  MyChat
//
//  Created by Chinh le on 5/22/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
extension UIView {
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    //MARK: Add cornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        
        get {
            return layer.cornerRadius
        }
    }
    //MARK: Add border
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    func addBorderToSide(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
            case .Left:
                border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
                break
            case .Right:
                border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
                break
            case .Top:
                border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
                break
            case .Bottom:
                border.frame = CGRect(x: 0, y: self.frame.size.height, width: frame.size.width, height: thickness)
                break
        }
        
        layer.addSublayer(border)
    }
    //MARK: Add shadow
    func addShadowCustom(_ shadowOffset: CGSize,_ shadowRadius: CGFloat,_ shadowOpacity: Float) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.masksToBounds = false
    }
    
    func addShadowDistanceBottom(_ shadowRadius: CGFloat,_ shadowOpacity: Float,_ distance: CGFloat,_ shadowSize: CGFloat) {
        let height = self.bounds.height
        let width = self.bounds.width
        let x = -shadowSize
        let y = height - (shadowSize * 0.4) + distance
        let contactRect = CGRect(x: x, y: y, width: width + (shadowSize * 2), height: shadowSize)
        self.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        
    }
    //MARK: Gradient color
    func gradientColor(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

