//
//  ViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/12/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var inputtedCardValue: UITextField!
    
    var cardValue = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    override func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
//        self.view.endEditing(true)
//    }

    func cardValueAlert() {
        let title = "Ouch."
        let message = "My brain only computes amounts between $0 and $40"
        let alert = UIAlertController(title: title, message: message,  preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Results View" {
            if NumberFormatter().number(from: inputtedCardValue.text!) != nil {
                cardValue = Double(NumberFormatter().number(from: inputtedCardValue.text!)!)
                
                if cardValue > 40.0 || cardValue < 0.0 {
                    cardValueAlert()
                    MixpanelHelper().track(
                        "Card alert show",
                        properties: ["Amount": cardValue]
                    )
                } else {
                    MixpanelHelper().track(
                        "Calcuate fare",
                        properties: ["Amount": cardValue]
                    )
                }

                
                
            } else {
                cardValue = 0.0
        }
            let rvc = segue.destination as! ResultsViewController
            rvc.cardValue = cardValue
        }
    }
}

