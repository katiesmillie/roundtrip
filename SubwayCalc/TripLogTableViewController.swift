//
//  TripLogTableViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 8/1/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData



class TripLogTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, EditDateViewControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!

    var selectedTripDate: NSDate?
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "TripLog")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "dateTime", ascending: false)
        fetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
        
        let frc = NSFetchedResultsController(
        fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "name", cacheName: nil)
        
        frc.delegate = self
        return frc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error: NSError? = nil
        
        if(fetchedResultsController.performFetch(&error) == false) {
            print("An error: \(error?.localizedDescription)")
        }
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            if sections.isEmpty == false {  // if this is zero view crashes if there is no data
                let currentSection = sections[section] as! NSFetchedResultsSectionInfo
                return currentSection.numberOfObjects
            }
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        let trip = fetchedResultsController.objectAtIndexPath(indexPath) as! TripLog
        let dateString = NSDateFormatter.localizedStringFromDate(trip.dateTime, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        cell.textLabel?.text = dateString

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as? NSManagedObject {
                self.managedObjectContext.deleteObject(item)
                self.managedObjectContext.save(nil)
            }
        }
    }
    
    //  MARK:  NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
            
            switch type {
            case .Insert:
                if let insertIndexPath = newIndexPath {
                    self.tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            case .Delete:
                if let deleteIndexPath = indexPath {
                    self.tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: .Fade)
                }
            case .Update:
                if let updateIndexPath = indexPath {
                   
                }
            case .Move:
                if let deleteIndexPath = indexPath {
                }
            }
        }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
         updateStats()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Edit Date" {
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                if let trip = fetchedResultsController.objectAtIndexPath(indexPath) as? TripLog {
                    selectedTripDate = trip.dateTime
                }
            }
            var editDateVC = segue.destinationViewController as! EditDateViewController
                editDateVC.delegate = self
                editDateVC.tripDate = self.selectedTripDate
        }
    }
    
    func didSelectNewDate(controller: EditDateViewController, myDatePicker: UIDatePicker) {
        selectedTripDate = myDatePicker.date
        
        if let updateIndexPath = self.tableView.indexPathForSelectedRow() {
            
            let cell = self.tableView.cellForRowAtIndexPath(updateIndexPath)
            let dateString = NSDateFormatter.localizedStringFromDate(selectedTripDate!, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
            cell!.textLabel?.text = dateString
        
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: myDatePicker.date)
            
            if let trip = fetchedResultsController.objectAtIndexPath(updateIndexPath) as? TripLog {
                trip.dateTime = selectedTripDate!
                trip.day = components.day
                trip.month = components.month
                trip.year = components.year
                
                self.managedObjectContext.save(nil)
            }
        }
    }
    
    func updateStats(){
        self.performSegueWithIdentifier("Unwind Segue", sender: self)
    }
    
}





