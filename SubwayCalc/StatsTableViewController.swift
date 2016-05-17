//
//  StatsTableViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 3/1/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData

class StatsTableViewController: UITableViewController {

    var totalTrips: Int?
    var fetchedResults: [TripLog]?
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResults()
    }

    
    func fetchResults () {
        let fetchRequest = NSFetchRequest(entityName:"TripLog")
        fetchedResults = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as? [TripLog]
        avgTripsPerThirtydays()
    }
    
    
    func avgTripsPerThirtydays() {
        guard let fetchedResults = fetchedResults else { return }
        totalTrips = Int(fetchedResults.count)
        
        // Get the first record
        let sortedResults = fetchedResults.sort { $0.dateTime < $1.dateTime }
        let firstResult = sortedResults.first
        _ = firstResult?.dateTime
        
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


}
