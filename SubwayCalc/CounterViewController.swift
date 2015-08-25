//
//  CounterViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/23/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData


 class CounterViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var thirtyDayLabel: UILabel!
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
  
    var totalTrips = 0
    
    var startDate: NSDate! {
        return endDate.dateByAddingTimeInterval(-60*60*24*30)
    }
    
    var endDate: NSDate! {
        return NSDate()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
  

    @IBAction func logTrip(sender: UIButton) {
        logNewTrip()
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    
    func fetchNumberTrips () {
        let fetchRequest = NSFetchRequest(entityName:"TripLog")
        let fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [TripLog]
        totalTrips = Int(fetchedResults.count)
        println(totalTrips)
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
        thirtyDayLabel.text = String(tripsInThirtyDays)
    }
    
    @IBAction func unwindToStats(sender: UIStoryboardSegue) {
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    
}