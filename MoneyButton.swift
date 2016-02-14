//
//  MoneyButton.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 2/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class MoneyButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = CGRectGetHeight(bounds) / 2
        self.backgroundColor = UIColor.raspberry()
    }
}
