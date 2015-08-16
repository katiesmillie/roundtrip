//
//  CounterViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/23/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData

class CounterViewController: UIViewController, DatePickerViewControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var totalTrips = 0
    var startDate: NSDate!
    var endDate: NSDate!
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var thirtyDayCounterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNumberTrips()
        fetchStartDate()
        fetchTripsInThirtyDayPeriod()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchNumberTrips()
        fetchStartDate()
        fetchTripsInThirtyDayPeriod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logTrip(sender: UIButton) {
        logNewTrip ()
        fetchNumberTrips()
    }
    
    // this function gets the updated start date from core data. can remove mydatepicker
    
    func didSelectDate(controller: DatePickerViewController) {
        self.fetchStartDate()
    }

    func fetchTripsInThirtyDayPeriod () {
        let fetchRequest = NSFetchRequest(entityName:"TripLog")
        let fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [TripLog]
        
        var filteredResults = Array<TripLog>()
        for result in fetchedResults {
            if result.dateTime.compare(startDate) == NSComparisonResult.OrderedDescending && result.dateTime.compare(endDate) == NSComparisonResult.OrderedAscending {
                    filteredResults.append(result)
            }
        }
        let tripsInThirtyDays = filteredResults.count
        thirtyDayCounterLabel.text = String(tripsInThirtyDays)

        setAverage(tripsInThirtyDays)
    }
    
    func setAverage(tripsInThirtyDays: Int) {
        var averageValue = 0.0
        if tripsInThirtyDays > 0 {
            averageValue = 116.5 / Double(tripsInThirtyDays)
        } else {
            averageValue = 0.00
        }
        averageLabel.text = String(format: "$ %.2f", averageValue)
    }
    
    func fetchNumberTrips () {
        let fetchRequest = NSFetchRequest(entityName:"TripLog")
        let fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [TripLog]
        
        totalTrips = Int(fetchedResults.count)
        counterLabel.text = "\(Int(totalTrips))"
    }
    
    func logNewTrip () {
        let newEntity = NSEntityDescription.insertNewObjectForEntityForName("TripLog", inManagedObjectContext: self.managedObjectContext) as! TripLog
        let date = NSDate()
        newEntity.dateTime = date
        newEntity.name = "Log"
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
        
        newEntity.year = components.year
        newEntity.month = components.month
        newEntity.day = components.day
        
        self.managedObjectContext.save(nil)
        fetchTripsInThirtyDayPeriod()

    }
    
    func fetchStartDate () {
        let fetchRequest = NSFetchRequest(entityName:"DateRange")
        let fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [DateRange]
        
        if (fetchedResults.first?.startDate != nil) {
            startDate = fetchedResults.first?.startDate
            let startDateString = NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .MediumStyle, timeStyle: .NoStyle)
            startDateLabel.text = startDateString
            calculateEndDate(startDate)
        } else {
            createStartDate()
        }
    }
    
    func createStartDate () {
        let newEntity = NSEntityDescription.insertNewObjectForEntityForName("DateRange", inManagedObjectContext: self.managedObjectContext) as! DateRange
        startDate = NSDate()
        newEntity.startDate = startDate
        self.managedObjectContext.save(nil)

        let startDateString = NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .MediumStyle, timeStyle: .NoStyle)
        startDateLabel.text = startDateString
        calculateEndDate(startDate)
    }
    
    func calculateEndDate (startDate: NSDate) {
        endDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: 30, toDate: startDate, options: nil)
        let endDateString = NSDateFormatter.localizedStringFromDate(endDate!, dateStyle: .MediumStyle, timeStyle: .NoStyle)
        endDateLabel.text = endDateString
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Date Picker" {
            var datePickerVC = segue.destinationViewController as! DatePickerViewController
            datePickerVC.delegate = self
            datePickerVC.startDate = self.startDate
        }
    }

}