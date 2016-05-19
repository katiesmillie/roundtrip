//
//  MoneyButton.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 2/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class MoneyButton: UIButton {
    
    var bottomBorder: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        styleButton()
    }
    
    func styleButton() {
        layer.cornerRadius = CGRectGetHeight(bounds) / 18
        self.backgroundColor = UIColor.mtaBlueFlip()
        
//        bottomBorder = UIView(frame: CGRectMake(0, -4, self.frame.size.width, self.frame.size.height))
//        bottomBorder?.backgroundColor = UIColor.mtaBlueFlip()
//        bottomBorder?.layer.cornerRadius = CGRectGetHeight(bounds) / 18
//        bottomBorder?.userInteractionEnabled = false
//        guard let bottomBorder = bottomBorder else { return }
//        self.addSubview(bottomBorder)
//        self.sendSubviewToBack(bottomBorder)
    }
    
    
}
