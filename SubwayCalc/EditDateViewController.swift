//
//  EditDateViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 8/7/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData

protocol EditDateViewControllerDelegate {
    func didSelectNewDate(controller: EditDateViewController, myDatePicker: UIDatePicker)
}

class EditDateViewController: UIViewController {

    @IBOutlet weak var myDatePicker: UIDatePicker?

    var delegate: EditDateViewControllerDelegate?
    var tripDate: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylePicker()
    }
    
    private func stylePicker() {
        myDatePicker?.datePickerMode = UIDatePickerMode.Date
        myDatePicker?.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        guard let tripDate = tripDate else { return }
        myDatePicker?.date = tripDate
        myDatePicker?.maximumDate = NSDate()
        myDatePicker?.setValue(UIColor.whiteColor(), forKey: "textColor")
        myDatePicker?.performSelector("setHighlightsToday:", withObject: UIColor.whiteColor())
    }
    
    func datePickerChanged(myDatePicker: UIDatePicker) {
        tripDate = myDatePicker.date
    }
    
    @IBAction func didSelectNewDate(sender: UIButton) {
        guard let myDatePicker = myDatePicker else { return }
        datePickerChanged(myDatePicker)
        delegate?.didSelectNewDate(self, myDatePicker: myDatePicker)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
