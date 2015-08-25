//
//  RideEstimatorViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 8/19/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class RideEstimatorViewController: UIViewController {

    @IBOutlet weak var perDayLabel: UITextField!
    @IBOutlet weak var perWeekLabel: UITextField!
    @IBOutlet weak var perMonthLabel: UITextField!
    @IBOutlet weak var estimatedRidesLabel: UILabel!
    @IBOutlet weak var monthlyPassStringLabel: UILabel!
    @IBOutlet weak var monthlyPassDiffLabel: UILabel!
    
    var perDay: Int {
        get {
            return Int(NSNumberFormatter().numberFromString(perDayLabel.text)!)
        }
        set {
            perDayLabel.text = String(newValue)
        }
    }
    var perWeek: Int {
        get {
            return Int(NSNumberFormatter().numberFromString(perWeekLabel.text)!)
        }
        set {
            perWeekLabel.text = String(newValue)
        }
    }
    var perMonth: Int {
        get {
            return Int(NSNumberFormatter().numberFromString(perMonthLabel.text)!)
        }
        set {
            perMonthLabel.text = String(newValue)
        }
    }
    
    var estimatedRides: Int!
    var monthlyPassString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRides()
    }
    
    func setRides() {
        let estimatedRidesDouble = (Double(perDay*perWeek)*4.2)+(Double(perMonth))
        estimatedRides = Int(estimatedRidesDouble)
        estimatedRidesLabel.text = String(stringInterpolationSegment: estimatedRides)
        setMonthlyPass()
    }
    
        func setMonthlyPass() {
        let monthlyPassDifference = Double(estimatedRides)*2.75 - 116.50
        
        if monthlyPassDifference > 0 {
            monthlyPassString = "saved with a monthly pass"
        } else {
            monthlyPassString = "wasted with a monthly pass"
        }
        monthlyPassStringLabel.text = monthlyPassString
        monthlyPassDiffLabel.text = String(format: "$ %.2f", monthlyPassDifference)
    }

    @IBAction func incrementDay(sender: UIButton) {
        if perDay < 10 {
            perDay += 1
        }  else {
            perDay = 0
        }
         setRides()
    }
    
    @IBAction func decrememntDay(sender: UIButton) {
        if perDay == 0 {
            perDay = 10
        } else {
            perDay -= 1
        }
         setRides()
    }
    
    @IBAction func incrementWeek(sender: UIButton) {
        if perWeek < 7 {
            perWeek += 1
        }  else {
            perWeek = 0
        }
         setRides()
    }
    
    @IBAction func decrememntWeek(sender: UIButton) {
        if perWeek == 0 {
            perWeek = 7
        } else {
            perWeek -= 1
        }
         setRides()
    }
    @IBAction func incrementMonth(sender: UIButton) {
        if perMonth < 40 {
            perMonth += 1
        }  else {
            perMonth = 0
        }
         setRides()
    }
    
    @IBAction func decrememntMonth(sender: UIButton) {
        if perMonth == 0 {
            perMonth = 40
        } else {
            perMonth -= 1
        }
         setRides()
    }

}





