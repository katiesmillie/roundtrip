//
//  RideEstimatorViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 8/19/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class RideEstimatorViewController: UIViewController {
    
    @IBOutlet weak var perDayLabel: UITextField?
    @IBOutlet weak var perWeekLabel: UITextField?
    @IBOutlet weak var perMonthLabel: UITextField?
    @IBOutlet weak var estimatedRidesLabel: UILabel?
    @IBOutlet weak var monthlyPassStringLabel: UILabel?
    @IBOutlet weak var monthlyPassDiffLabel: UILabel?
    
    var perDay: Int {
        get {
            return Int(perDayLabel!.text!)!
        }
        set {
            perDayLabel?.text = String(describing: newValue)
        }
    }
    var perWeek: Int {
        get {
            return Int(perWeekLabel!.text!)!
        }
        set {
            perWeekLabel?.text = String(describing: newValue)
        }
    }
    var perMonth: Int {
        get {
            return Int(perMonthLabel!.text!)!
        }
        set {
            perMonthLabel?.text = String(describing: newValue)
        }
    }
    
    var estimatedRides: Int!
    var monthlyPassString: String!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var estimatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = estimatorView.bounds.size
        scrollView.addSubview(estimatorView)
        view.addSubview(scrollView)
        automaticallyAdjustsScrollViewInsets = true
        setRides()
    }
    
    func setRides() {
        let estimatedRidesDouble = (Double(perDay*perWeek)*4.2)+(Double(perMonth))
        estimatedRides = Int(estimatedRidesDouble)
        estimatedRidesLabel?.text = String(describing: estimatedRides)
        setMonthlyPass()
    }
    
    func setMonthlyPass() {
        let monthlyPassDifference = Double(estimatedRides)*2.62 - 116.50
        
        if monthlyPassDifference > 0 {
            monthlyPassString = "saved with a monthly pass"
            monthlyPassDiffLabel?.textColor = UIColor.green
        } else {
            monthlyPassString = "wasted with a monthly pass"
            monthlyPassDiffLabel?.textColor = UIColor.red
        }
        monthlyPassStringLabel?.text = monthlyPassString
        monthlyPassDiffLabel?.text = String(format: "$ %.2f", monthlyPassDifference)
    }
    
    @IBAction func incrementDay(_ sender: UIButton) {
        if perDay < 10 {
            perDay += 1
        }  else {
            perDay = 0
        }
        setRides()
    }
    
    @IBAction func decrememntDay(_ sender: UIButton) {
        if perDay == 0 {
            perDay = 10
        } else {
            perDay -= 1
        }
        setRides()
    }
    
    @IBAction func incrementWeek(_ sender: UIButton) {
        if perWeek < 7 {
            perWeek += 1
        }  else {
            perWeek = 0
        }
        setRides()
    }
    
    @IBAction func decrememntWeek(_ sender: UIButton) {
        if perWeek == 0 {
            perWeek = 7
        } else {
            perWeek -= 1
        }
        setRides()
    }
    @IBAction func incrementMonth(_ sender: UIButton) {
        if perMonth < 40 {
            perMonth += 1
        }  else {
            perMonth = 0
        }
        setRides()
    }
    
    @IBAction func decrememntMonth(_ sender: UIButton) {
        if perMonth == 0 {
            perMonth = 40
        } else {
            perMonth -= 1
        }
        setRides()
    }
    
}





