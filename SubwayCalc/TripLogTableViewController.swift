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
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!

    var selectedTripDate: Date?
    
    lazy var fetchedResultsController: NSFetchedResultsController<TripLog> = {
       
        let fetchRequest: NSFetchRequest<TripLog> = TripLog.fetchRequest() as! NSFetchRequest<TripLog>
        
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "dateTime", ascending: false)
        fetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "name", cacheName: nil)
        
        fetchedResultsController.delegate = self
        return fetchedResultsController
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            if sections.isEmpty == false {
                let currentSection = sections[section] 
                return currentSection.numberOfObjects
            }
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) 
        let trip = fetchedResultsController.object(at: indexPath) 
        let dateString = DateFormatter.localizedString(from: trip.dateTime, dateStyle: .long, timeStyle: .none)
        cell.textLabel?.text = dateString

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = self.fetchedResultsController.object(at: indexPath)
            self.managedObjectContext.delete(item)
            try? self.managedObjectContext.save()
        }
    }
    
    //  MARK:  NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            
            switch type {
            case .insert:
                if let insertIndexPath = newIndexPath {
                    self.tableView.insertRows(at: [insertIndexPath], with: UITableViewRowAnimation.fade)
                }
            case .delete:
                if let deleteIndexPath = indexPath {
                    self.tableView.deleteRows(at: [deleteIndexPath], with: .fade)
                }
            case .update: break
            case .move: break
            }
        }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
        updateStats()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit Date" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                if let trip = fetchedResultsController.object(at: indexPath) as? TripLog {
                    selectedTripDate = trip.dateTime
                }
            }
            var editDateVC = segue.destination as! EditDateViewController
                editDateVC.delegate = self
                editDateVC.tripDate = self.selectedTripDate
        }
    }
    
    func didSelectNewDate(_ controller: EditDateViewController, myDatePicker: UIDatePicker) {
        selectedTripDate = myDatePicker.date
        
        if let updateIndexPath = self.tableView.indexPathForSelectedRow {
            
            let cell = self.tableView.cellForRow(at: updateIndexPath)
            let dateString = DateFormatter.localizedString(from: selectedTripDate!, dateStyle: .medium, timeStyle: .short)
            cell!.textLabel?.text = dateString
        
//            let calendar = NSCalendar.currentCalendar()
//            let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: myDatePicker.date)
            
            if let trip = fetchedResultsController.object(at: updateIndexPath) as? TripLog {
                trip.dateTime = selectedTripDate!
                
//                trip.day = components.day
//                trip.month = components.month
//                trip.year = components.year
                
                try? self.managedObjectContext.save()
            }
        }
    }
    
    func updateStats(){
        self.performSegue(withIdentifier: "Unwind Segue", sender: self)
    }
    
}





