//
//  DatePickerViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 8/3/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData


protocol DatePickerViewControllerDelegate {
    func didSelectDate(controller: DatePickerViewController)
}

class DatePickerViewController: UIViewController {
    
    var delegate: DatePickerViewControllerDelegate?
    var startDate: NSDate!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    @IBOutlet weak var myDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        myDatePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        myDatePicker.date = startDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func datePickerChanged(myDatePicker: UIDatePicker) {
        startDate = myDatePicker.date
        updateStartDate(startDate)
    }
    
    @IBAction func didSelectStartDate(sender: UIButton) {
        datePickerChanged(myDatePicker)
        
        if let delegate = self.delegate {
            delegate.didSelectDate(self)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateStartDate (newDate: NSDate) {
        let fetchRequest = NSFetchRequest(entityName:"DateRange")
        let fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [DateRange]
      
        let entity = fetchedResults.first
        entity!.startDate = newDate
        self.managedObjectContext.save(nil)
    }
    
}
