//
//  ResultsViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/12/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {

    @IBOutlet weak var cardAmountLabel: UILabel?
    @IBOutlet weak var displayAmountToAdd1: UILabel?
    @IBOutlet weak var displayBonusPct1: UILabel?
    @IBOutlet weak var displayCardValue1: UILabel?
    @IBOutlet weak var displayRides1: UILabel?
    
    @IBOutlet weak var displayAmountToAdd2: UILabel?
    @IBOutlet weak var displayBonusPct2: UILabel?
    @IBOutlet weak var displayCardValue2: UILabel?
    @IBOutlet weak var displayRides2: UILabel?
    
    @IBOutlet weak var displayAmountToAdd3: UILabel?
    @IBOutlet weak var displayBonusPct3: UILabel?
    @IBOutlet weak var displayCardValue3: UILabel?
    @IBOutlet weak var displayRides3: UILabel?
    
    var cardValue: Double = 0.0
    var amountsToAdd: [Double] = []
    var amountsNeeded: [Double] = []
    var bonusPcts: [Double] = []
    var rides: [Double] = []
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var resultsView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Suggested Amounts"
        cardAmountLabel?.text = String(format: "$ %.2f MetroCard", cardValue)
       
        displayAmounts()
       
        scrollView?.contentSize = (resultsView?.bounds.size)!
        scrollView?.addSubview(resultsView!)
        view.addSubview(scrollView!)
        scrollView?.alwaysBounceHorizontal = false
    }
    
    func displayAmounts() {
        let calc = CalculatorModel(cardValue: cardValue)
      
        amountsToAdd = calc.calcAmountsArray()
        amountsNeeded = calc.calcAmountNeededFromAmountToAdd(amountsToAdd)
        bonusPcts = calc.calcBonus(amountsToAdd)
        rides = calc.calcNumberRides(amountsToAdd)
        
        displayAmountToAdd1?.text = String(format: "$ %.2f", amountsToAdd[0])
        displayBonusPct1?.text = String(format: "$ %.2f", bonusPcts[0])
        displayCardValue1?.text = String(format: "$ %.2f", amountsNeeded[0])
        displayRides1?.text = String(format: "%.0f", rides[0])
        
        displayAmountToAdd2?.text = String(format: "$ %.2f", amountsToAdd[1])
        displayBonusPct2?.text = String(format: "$ %.2f", bonusPcts[1])
        displayCardValue2?.text = String(format: "$ %.2f", amountsNeeded[1])
        displayRides2?.text = String(format: "%.0f", rides[1])
        
        displayAmountToAdd3?.text = String(format: "$ %.2f", amountsToAdd[2])
        displayBonusPct3?.text = String(format: "$ %.2f", bonusPcts[2])
        displayCardValue3?.text = String(format: "$ %.2f", amountsNeeded[2])
        displayRides3?.text = String(format: "%.0f", rides[2])
    }
}
