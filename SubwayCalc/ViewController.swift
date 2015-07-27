//
//  ViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/12/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var inputtedCardValue: UITextField!
    
    var cardValue = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cardValueAlert() {
        let title = "Whoops"
        let message = "I can only process amounts between $0 and $100"
        let alert = UIAlertController(title: title, message: message,  preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: {
            action in
        })
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Results View" {
           
            if NSNumberFormatter().numberFromString(inputtedCardValue.text) != nil {
                cardValue = Double(NSNumberFormatter().numberFromString(inputtedCardValue.text)!)
                
                if cardValue > 99.99 || cardValue < 0.0 {
                    cardValueAlert()
                }
                
            } else {
                cardValue = 0.0
        }
        
        var rvc = segue.destinationViewController as! ResultsViewController
        rvc.cardValue = cardValue
            
        }
    }
    
}

