//
//  RootViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 5/2/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMainUI()
    }
    
    func embedViewController(viewController: UIViewController) {
        removePreviousViewController()
        addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        let views = ["view": viewController.view]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        viewController.didMoveToParentViewController(self)
        currentViewController = viewController
    }
    
    private func removePreviousViewController() {
        guard let currentViewController = currentViewController else { return }
        currentViewController.willMoveToParentViewController(nil)
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParentViewController()
    }
    
    internal func showMainUI() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let navController = storyboard.instantiateInitialViewController() as? UINavigationController {
            embedViewController(navController)
            dismissModalIfNeeded()
        }
    }
    
    internal func showMenu() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        if let navController = storyboard.instantiateInitialViewController() as? UINavigationController {
            navController.modalPresentationStyle = .OverCurrentContext
            presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    internal func showTripLog() {
        let storyboard = UIStoryboard(name: "TripLog", bundle: nil)
        if let navController = storyboard.instantiateInitialViewController() as? UINavigationController {
            navController.modalPresentationStyle = .OverCurrentContext
            presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    internal func showCalculator() {
        let storyboard = UIStoryboard(name: "Calculator", bundle: nil)
        if let navController = storyboard.instantiateInitialViewController() as? UINavigationController {
            embedViewController(navController)
            dismissModalIfNeeded()
        }
    }
    
    internal func showEstimator() {
        let storyboard = UIStoryboard(name: "Estimator", bundle: nil)
        if let navController = storyboard.instantiateInitialViewController() as? UINavigationController {
            embedViewController(navController)
            dismissModalIfNeeded()
        }
    }
    
    internal func showAbout() {
        let storyboard = UIStoryboard(name: "About", bundle: nil)
        if let navController = storyboard.instantiateInitialViewController() as? UINavigationController {
            embedViewController(navController)
            dismissModalIfNeeded()
        }
    }
    
    private func dismissModalIfNeeded(completion: (()->())? = nil) {
        guard let modal = presentedViewController else {
            completion?()
            return
        }
        modal.dismissViewControllerAnimated(true, completion: completion)
    }
    
}

extension UIViewController {
    
    func rootViewController() -> RootViewController? {
        if let root = self as? RootViewController {
            return root
        }
        else if let parent = parentViewController {
            return parent.rootViewController()
        }
        else if let presenter = presentingViewController {
            return presenter.rootViewController()
        }
        else {
            return nil
        }
    }
    
}