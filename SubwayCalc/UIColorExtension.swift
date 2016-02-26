//
//  UIColorExtension.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 2/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class func rgb(red red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return rgba(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public class func rgba(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    public class func mtaBlue() -> UIColor {
        return UIColor.rgb(red: 11, green: 87, blue: 166)
    }
    
    public class func mtaYellow() -> UIColor {
        return UIColor.rgb(red: 250, green: 202, blue: 35)
    }
    
    public class func mtaBlueSwap() -> UIColor {
        return UIColor.rgb(red: 166, green: 11, blue: 87)
    }
    
    public class func mtaBlueFlip() -> UIColor {
        return UIColor.rgb(red: 87, green: 166, blue: 11)
    }
    
}
