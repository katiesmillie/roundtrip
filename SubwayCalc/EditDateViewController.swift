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
    func didSelectNewDate(_ controller: EditDateViewController, myDatePicker: UIDatePicker)
}

class EditDateViewController: UIViewController {
    
    @IBOutlet weak var myDatePicker: UIDatePicker?
    
    var delegate: EditDateViewControllerDelegate?
    var tripDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDatePicker?.datePickerMode = UIDatePickerMode.date
        myDatePicker?.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        myDatePicker?.date = tripDate!
        myDatePicker?.maximumDate = Date()
    }
    
    func datePickerChanged(_ myDatePicker: UIDatePicker) {
        tripDate = myDatePicker.date
    }
    
    @IBAction func didSelectNewDate(_ sender: UIButton) {
        datePickerChanged(myDatePicker!)
        
        if let delegate = delegate {
            delegate.didSelectNewDate(self, myDatePicker: myDatePicker!)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
