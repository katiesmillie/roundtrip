//
//  Menu.Swift
//  SubwayCalc
//
//  Created by Katie Smillie on 5/19/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation
import BTNavigationDropdownMenu

public enum MenuItem {
    case TripLogger
    case FareCalculator
    case Estimator
    case About
}

public let items: [MenuItem] = [.TripLogger, .FareCalculator, .Estimator, .About]


public struct Menu {
    
    static func setupMenu(navController: UINavigationController, index: Int) -> BTNavigationDropdownMenu {
        let items = ["Trip Counter", "Fare Calculator", "Ride Estimator", "About"]
        
        navController.navigationBar.translucent = false
        navController.navigationBar.barTintColor = UIColor.mtaBlueSwapAlpha()
        
        navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let menuView = BTNavigationDropdownMenu(navigationController: navController, title: items[index], items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = navController.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor.mtaBlueSwapAlpha()
        menuView.keepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Avenir", size: 17)
        menuView.cellTextLabelAlignment = .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.35
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3

        return menuView
    }
    
    static func getMenuItem(indexPath: Int) -> MenuItem {
        return items[indexPath]
    }
    
    static func showItemAtIndexPath(viewController: UIViewController, indexPath: Int) {
        switch getMenuItem(indexPath) {
            case .TripLogger: viewController.rootViewController()?.showMainUI()
            case .FareCalculator: viewController.rootViewController()?.showCalculator()
            case .Estimator: viewController.rootViewController()?.showEstimator()
            case .About: viewController.rootViewController()?.showAbout()
        }
    }
    
}
