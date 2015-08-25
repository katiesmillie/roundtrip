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

    @IBOutlet weak var myDatePicker: UIDatePicker!

    var delegate: EditDateViewControllerDelegate?
    var tripDate: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         myDatePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
         myDatePicker.date = tripDate
         myDatePicker.maximumDate = NSDate()
    }
    
    func datePickerChanged(myDatePicker: UIDatePicker) {
        tripDate = myDatePicker.date
    }
    
    @IBAction func didSelectNewDate(sender: UIButton) {
        datePickerChanged(myDatePicker)
        
        if let delegate = self.delegate {
            delegate.didSelectNewDate(self, myDatePicker: myDatePicker)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
