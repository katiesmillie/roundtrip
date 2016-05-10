//
//  CircleButton.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 3/1/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleButton()
    }
    
    func styleButton() {
        layer.cornerRadius = CGRectGetHeight(bounds) / 2

    }

}
