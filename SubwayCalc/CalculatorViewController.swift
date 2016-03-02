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
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func styleView() {
        self.view.backgroundColor = UIColor.mtaBlueSwap()
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
        if segue.identifier == "Results View" {
            guard let inputtedCardValue = inputtedCardValue?.text else { return }
            guard let formatedCardValue = NSNumberFormatter().numberFromString(inputtedCardValue) else { return }
            cardValue = Double(formatedCardValue)
                
            if cardValue > 40.0 || cardValue < 0.0 {
                cardValueAlert()
                MixpanelHelper.track(
                    "Card value alert",
                    properties: ["Amount": cardValue]
                )            } else {
                MixpanelHelper.track(
                    "Calcuate fare",
                    properties: ["Amount": cardValue]
                )
            }
            
            guard let rvc = segue.destinationViewController as? ResultsViewController else { return }
            rvc.amountOnCard = cardValue
        }
    }
    
}

