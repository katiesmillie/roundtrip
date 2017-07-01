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
    
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
  
    var totalTrips = 0
    
    var startDate: Date! {
        return endDate.addingTimeInterval(-60*60*24*30)
    }
    
    var endDate: Date! {
        return Date()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
  

    @IBAction func logTrip(_ sender: UIButton) {
        logNewTrip()
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
        MixpanelHelper().track("Log trip")
    }
    
    func fetchNumberTrips () {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"TripLog")
        let fetchedResults = try? self.managedObjectContext.fetch(fetchRequest) as! [TripLog]
        totalTrips = Int((fetchedResults?.count)!)
        counterLabel?.text = "\(Int(totalTrips))"
    }
    
    func logNewTrip () {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "TripLog", into: self.managedObjectContext) as! TripLog
        let date = Date()
        newEntity.dateTime = date
        newEntity.name = "Log"
        
        
// ------ code below is crashing when data store is empty on first log / set year ------------ //
        
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
//        newEntity.year = components.year
//        newEntity.month = components.month
//        newEntity.day = components.day
        
        try? self.managedObjectContext.save()
    }
    
    func fetchTripsInThirtyDayPeriod () {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"TripLog")
        let fetchedResults = try? self.managedObjectContext.fetch(fetchRequest) as! [TripLog]
        var filteredResults = Array<TripLog>()
        for result in fetchedResults! {
            if result.dateTime.compare(startDate) == ComparisonResult.orderedDescending && result.dateTime.compare(endDate) == ComparisonResult.orderedAscending {
                filteredResults.append(result)
            }
        }
        let tripsInThirtyDays = filteredResults.count
        thirtyDayLabel?.text = String(tripsInThirtyDays)
    }
    
    @IBAction func unwindToStats(_ sender: UIStoryboardSegue) {
        fetchNumberTrips()
        fetchTripsInThirtyDayPeriod()
    }
    
}
