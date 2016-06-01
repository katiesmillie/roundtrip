//
//  TripLogTableViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 8/1/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData

class TripLogTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, EditDateViewControllerDelegate {
    
    var managedObjectContext : NSManagedObjectContext? {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return nil }
        return appDelegate.managedObjectContext
    }

    var selectedTripDate: NSDate?
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        let fetchRequest = NSFetchRequest(entityName: "TripLog")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "dateTime", ascending: false)
        fetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
        guard let managedObjectContext = self.managedObjectContext else { return nil }
        let frc = NSFetchedResultsController(
        fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: "name", cacheName: nil)
        
        frc.delegate = self
        return frc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
             print("An error: \(error.localizedDescription)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections where sections.isEmpty == false {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TripCell", forIndexPath: indexPath)
        guard let trip = fetchedResultsController?.objectAtIndexPath(indexPath) as? TripLog else { return cell }
        let dateString = NSDateFormatter.localizedStringFromDate(trip.dateTime, dateStyle: .LongStyle, timeStyle: .NoStyle)
        cell.textLabel?.text = dateString
        cell.textLabel?.textColor = UIColor.mtaBlueSwap()

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let item = fetchedResultsController?.objectAtIndexPath(indexPath) as? NSManagedObject {
                managedObjectContext?.deleteObject(item)
                do {
                    try managedObjectContext?.save()
                }
                catch _ {
                }
            }
        }
    }
    
    //  MARK:  NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
            
            switch type {
            case .Insert:
                if let insertIndexPath = newIndexPath {
                    tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            case .Delete:
                if let deleteIndexPath = indexPath {
                    tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: .Fade)
                }
            case .Update:
                if let _ = indexPath {
                }
            case .Move:
                if let _ = indexPath {
                }
            }
        }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
        updateStats()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Edit Date" {
            if let indexPath = tableView.indexPathForSelectedRow, trip = fetchedResultsController?.objectAtIndexPath(indexPath) as? TripLog {
                selectedTripDate = trip.dateTime
            }
            if let editDateVC = segue.destinationViewController as? EditDateViewController {
                editDateVC.delegate = self
                editDateVC.tripDate = self.selectedTripDate
            }
        }
    }
    
    func didSelectNewDate(controller: EditDateViewController, myDatePicker: UIDatePicker) {
        selectedTripDate = myDatePicker.date
        guard let selectedTripDate = selectedTripDate else { return }

        guard let updateIndexPath = tableView.indexPathForSelectedRow else { return }
        let cell = tableView.cellForRowAtIndexPath(updateIndexPath)
        let dateString = NSDateFormatter.localizedStringFromDate(selectedTripDate, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        cell!.textLabel?.text = dateString
        
        guard let trip = fetchedResultsController?.objectAtIndexPath(updateIndexPath) as? TripLog else { return }
        trip.dateTime = selectedTripDate

        do {
            try managedObjectContext?.save()
        }
        catch _ {
        }
    }
    
    func updateStats(){
        self.performSegueWithIdentifier("Unwind Segue", sender: self)
    }
    
    @IBAction func close(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}





