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
            guard let perDayLabelText = perDayLabel?.text else { return 0 }
            guard let formattedLabel = NSNumberFormatter().numberFromString(perDayLabelText) else { return 0 }
            return Int(formattedLabel)
        }
        set {
            perDayLabel?.text = String(newValue)
        }
    }
    var perWeek: Int {
        get {
            guard let perWeekLabelText = perWeekLabel?.text else { return 0 }
            guard let formattedLabel = NSNumberFormatter().numberFromString(perWeekLabelText) else { return 0 }
            return Int(formattedLabel)
        }
        set {
            perWeekLabel?.text = String(newValue)
        }
    }
    var perMonth: Int {
        get {
            guard let perMonthLabelText = perMonthLabel?.text else { return 0 }
            guard let formattedLabel = NSNumberFormatter().numberFromString(perMonthLabelText) else { return 0 }
            return Int(formattedLabel)
        }
        set {
            perMonthLabel?.text = String(newValue)
        }
    }
    
    var estimatedRides: Int?
    var monthlyPassString: String?
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var estimatorView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let estimatorView = estimatorView else { return }
        guard let scrollView = scrollView else { return }
        scrollView.contentSize = estimatorView.bounds.size
        scrollView.addSubview(estimatorView)
        view.addSubview(scrollView)
        self.automaticallyAdjustsScrollViewInsets = true

        setRides()
    }
    
    func setRides() {
        let estimatedRidesDouble = (Double(perDay*perWeek)*4.2)+(Double(perMonth))
        estimatedRides = Int(estimatedRidesDouble)
        guard let estimatedRides = estimatedRides else { return }
        estimatedRidesLabel?.text = String(stringInterpolationSegment: estimatedRides)
        
        setMonthlyPass()
    }
    
    func setMonthlyPass() {
        guard let estimatedRides = estimatedRides else { return }
        let avgWeekendDays = 2.48
        let monthlyPassFare = 116.50
        
        var monthlyPassDifference = Double(estimatedRides) * avgWeekendDays - monthlyPassFare
        
        if monthlyPassDifference > 0 {
            monthlyPassString = "saved with a monthly pass"
            monthlyPassDiffLabel?.textColor = UIColor.mtaBlueFlip()
        } else {
            monthlyPassDifference *= -1
            monthlyPassString = "wasted with a monthly pass"
            monthlyPassDiffLabel?.textColor = UIColor.mtaBlueSwap()
        }
        monthlyPassStringLabel?.text = monthlyPassString
        monthlyPassDiffLabel?.text = String(format: "$ %.2f", monthlyPassDifference)
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





