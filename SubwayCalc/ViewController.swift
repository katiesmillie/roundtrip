//
//  ViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/12/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var inputtedCardValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "roundtrip"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Results View" {
            var cardValue: Double
            
            if inputtedCardValue != nil {
                cardValue = Double(NSNumberFormatter().numberFromString(inputtedCardValue.text)!)
            }
            else {
                cardValue = 0.00
            }
            
        var rvc = segue.destinationViewController as! ResultsViewController
        rvc.cardValue = cardValue
        }
    }
}

