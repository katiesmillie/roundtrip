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
    
    public class func indigo() -> UIColor {
        return UIColor.rgb(red: 32, green: 33, blue: 59)
    }
    
    public class func peach() -> UIColor {
        return UIColor.rgb(red: 225, green: 46, blue: 52)
    }
    
    public class func raspberry() -> UIColor {
        return UIColor.rgb(red: 125, green: 38, blue: 57)
    }
    
    public class func grape() -> UIColor {
        return UIColor.rgb(red: 65, green: 38, blue: 58)
    }
    
    public class func bluegreen() -> UIColor {
        return UIColor.rgb(red: 36, green: 197, blue: 180)
    }


}
