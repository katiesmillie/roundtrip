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
        if let vc = storyboard.instantiateInitialViewController() as? CounterViewController {
            embedViewController(vc)
            dismissModalIfNeeded()
        }
    }
    
    internal func showCalculator() {
        let storyboard = UIStoryboard(name: "Calculator", bundle: nil)
        if let vc = storyboard.instantiateViewControllerWithIdentifier("Calculator") as? CalculatorViewController {
            embedViewController(vc)
            dismissModalIfNeeded()
        }
    }
    
    internal func showEstimator() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? RideEstimatorViewController {
            embedViewController(vc)
            dismissModalIfNeeded()
        }
    }
    
    internal func showAbout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? AboutViewController {
            embedViewController(vc)
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