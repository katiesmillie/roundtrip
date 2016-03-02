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
    
    @IBOutlet weak var counterLabel: UILabel?
    @IBOutlet weak var thirtyDayLabel: UILabel?
    @IBOutlet weak var counterButton: UIButton?
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
  
    var totalTrips = 0
    
    var startDate: NSDate {
        return NSDate().dateByAddingTimeInterval(-60*60*24*30)
    }
    
    var endDate: NSDate {
        return NSDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trip Log"
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    

    @IBAction func logTrip(sender: UIButton) {
        logNewTrip()
        MixpanelHelper.track("Log trip", properties: nil)
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    
    func fetchNumberTrips () {
        let fetchRequest = NSFetchRequest(entityName:"TripLog")
        guard let fetchedResults = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as? [TripLog] else { return }
        
        totalTrips = Int(fetchedResults.count)
        counterLabel?.text = "\(Int(totalTrips))"
    }
    
    func logNewTrip () {
        let newEntity = NSEntityDescription.insertNewObjectForEntityForName("TripLog", inManagedObjectContext: self.managedObjectContext) as! TripLog
        let date = NSDate()
        newEntity.dateTime = date
        newEntity.name = "Log"
    }
    
    func fetchTripsInThirtyDayPeriod () {
        let fetchRequest = NSFetchRequest(entityName:"TripLog")
        let fetchedResults = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as! [TripLog]
        var filteredResults = Array<TripLog>()
        for result in fetchedResults {
            if result.dateTime.compare(startDate) == NSComparisonResult.OrderedDescending && result.dateTime.compare(endDate) == NSComparisonResult.OrderedAscending {
                filteredResults.append(result)
            }
        }
        let tripsInThirtyDays = filteredResults.count
        thirtyDayLabel?.text = String(tripsInThirtyDays)
    }
    
    @IBAction func unwindToStats(sender: UIStoryboardSegue) {
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    
}