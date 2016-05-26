//
//  ViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/12/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputtedCardValue: UITextField?
    
    @IBOutlet weak var inputField: UITextField?
    var cardValue = 0.0
    var currentString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        inputtedCardValue?.delegate = self
        styleView()
        setupMenu()
    }
    
    func setupMenu() {
        guard let navController = self.navigationController else { return }
        let menuView = Menu.setupMenu(navController, index: 1, viewController: self)
        self.navigationItem.titleView = menuView
    }
    
    @IBAction func tappedMenu(sender: UIButton) {
        rootViewController()?.showMenu()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func styleView() {
        guard let inputField = inputField else { return }
        inputField.layer.cornerRadius = inputField.layer.frame.height / 2
    }
    
    func cardValueAlert() {
        let title = "Doh."
        let message = "My brain only computes amounts between $0 and $40"
        let alert = UIAlertController(title: title, message: message,  preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: {
            action in
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ResultsView" {
            guard let inputtedCardValue = inputtedCardValue?.text else { return }
            guard let formatedCardValue = NSNumberFormatter().numberFromString(inputtedCardValue) else { return }
            cardValue = Double(formatedCardValue)
                
            if cardValue > 40.0 || cardValue < 0.0 {
                cardValueAlert()
                MixpanelHelper.track(
                    "Card value alert",
                    properties: ["Amount": cardValue]
                )
            } else {
                MixpanelHelper.track(
                    "Calcuate fare",
                    properties: ["Amount": cardValue]
                )
            }
            
            if let navController = segue.destinationViewController as? UINavigationController {
                guard let resultsViewController = navController.viewControllers.first as? ResultsViewController else { return }
                resultsViewController.amountOnCard = cardValue
            }
            
            
        }
    }
    
}

