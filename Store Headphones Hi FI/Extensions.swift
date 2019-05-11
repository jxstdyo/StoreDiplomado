//
//  Extensions.swift
//  Store Headphones Hi FI
//
//  Created by Antonyo Chavez Saucedo on 4/1/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation

import Foundation
import UIKit

extension UIView{
    func anchor(top : NSLayoutYAxisAnchor?,
                leading : NSLayoutXAxisAnchor?,
                trailing : NSLayoutXAxisAnchor?,
                bottom : NSLayoutYAxisAnchor?,
                padding : UIEdgeInsets = .zero,
                size : CGSize = .zero){
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            topAnchor.constraint(equalTo : top, constant: padding.top).isActive = true
        }
        if let leading = leading{
            leadingAnchor.constraint(equalTo : leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo : trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo : bottom, constant: -padding.bottom).isActive = true
        }
        if size.width > 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height > 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    func dimensionAnchors(height : NSLayoutDimension?, heightMultiplier : CGFloat = 1, width : NSLayoutDimension?, widthMultiplier : CGFloat = 1){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height{
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
        }
        
        if let width = width{
            self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true
        }
        
    }
    
    func centerAnchor(centerX : NSLayoutXAxisAnchor?,
                      centerY : NSLayoutYAxisAnchor?){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX{
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY{
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    
    func addBlurBackground() {
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])
        
    }
    
    
    
}


class UI {
 
    static func getImageURL(_ imagenString : String) -> UIImage?{
        let url = URL(string: imagenString)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        return image
    }
}


extension UIColor{
    struct Flat {
        struct Green {
            static let Fern = UIColor(red:0.42, green:0.73, blue:0.45, alpha:1.0)
            static let MountainMeadow = UIColor(red:0.23, green:0.73, blue:0.62, alpha:1.0)
            static let ChateauGreen = UIColor(red:0.30, green:0.65, blue:0.39, alpha:1.0)
            static let PersianGreen = UIColor(red:0.17, green:0.65, blue:0.53, alpha:1.0)
        }
        
        struct Blue {
            static let PictonBlue = UIColor(red:0.36, green:0.68, blue:0.81, alpha:1.0)
            static let Mariner = UIColor(red:0.21, green:0.52, blue:0.77, alpha:1.0)
            static let CuriousBlue = UIColor(red:0.27, green:0.56, blue:0.71, alpha:1.0)
            static let Denim = UIColor(red:0.18, green:0.42, blue:0.68, alpha:1.0)
            static let Chambray = UIColor(red:0.28, green:0.34, blue:0.46, alpha:1.0)
            static let BlueWhale = UIColor(red:0.16, green:0.20, blue:0.30, alpha:1.0)
        }
        
        struct Violet {
            static let Wisteria = UIColor(red:0.56, green:0.41, blue:0.71, alpha:1.0)
            static let BlueGem = UIColor(red:0.33, green:0.24, blue:0.50, alpha:1.0)
        }
        
        struct Yellow {
            static let Energy = UIColor(red:0.95, green:0.83, blue:0.44, alpha:1.0)
            static let Turbo = UIColor(red:0.97, green:0.76, blue:0.24, alpha:1.0)
        }
        
        struct Orange {
            static let NeonCarrot = UIColor(red:0.97, green:0.62, blue:0.24, alpha:1.0)
            static let Sun = UIColor(red:0.93, green:0.47, blue:0.25, alpha:1.0)
        }
        
        struct Red {
            static let TerraCotta = UIColor(red:0.90, green:0.42, blue:0.36, alpha:1.0)
            static let Valencia = UIColor(red:0.80, green:0.28, blue:0.27, alpha:1.0)
            static let Cinnabar = UIColor(red:0.86, green:0.31, blue:0.28, alpha:1.0)
            static let WellRead = UIColor(red:0.70, green:0.20, blue:0.20, alpha:1.0)
        }
        
        struct Gray {
            static let AlmondFrost = UIColor(red:0.64, green:0.56, blue:0.52, alpha:1.0)
            static let WhiteSmoke = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            static let Iron = UIColor(red:0.82, green:0.84, blue:0.85, alpha:1.0)
            static let IronGray = UIColor(red:0.46, green:0.44, blue:0.42, alpha:1.0)
        }
    }
}



extension UIViewController {
    func curveTopCorners() {
        let path = UIBezierPath(roundedRect: self.view.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 30, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
}



extension UIImage {
    func resizedImage(newSize: CGSize) -> UIImage {
        guard self.size != newSize else { return self }
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

}


extension Double{
    func toCurrency() -> String {
        let outputString = "$ \(String(format: "%.2f", self))"
        return outputString
    }
}

extension String{
    var isNumeric : Bool {
        return Int(self) != nil
    }
    
    func maxLength(max : Int ) -> Bool{
        if self.count > max{
            return true
        } else {
            return false
        }
    }
    
    func isValidEmail() -> Bool {
        if self.count > 0{
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
        return true
    }
    
    func isEmpty() ->Bool{
        let newString = self.trimmingCharacters(in: NSCharacterSet.whitespaces)
        if newString.count > 0{
            return false
        }
        return true
    }
    
    func isLength(size : Int ) -> Bool{
        if self.count == size{
            return true
        } else {
            return false
        }
    }
    
    func isRange(start : Int, end : Int) -> Bool{
        if self.isNumeric {
            if let value = Int(self){
                if value >= start && value <= end{
                    return true
                }
            }
        }
        return false
    }
}
