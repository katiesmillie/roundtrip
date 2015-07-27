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
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var averageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNumberTrips()
        counterLabel.text = "\(Int(stepper.value))"
        setAverage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tripStepper(sender: UIStepper) {
        counterLabel.text = "\(Int(stepper.value))"
        setAverage()
        saveNumberTrips(Int(stepper.value))
    }
    
    @IBAction func resetAlert(sender: UIButton) {
        let title = "Hold up"
        let message = "You sure you want to reset your trips?"
        
        let alert = UIAlertController(title: title, message: message,  preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: {
            action in
            self.stepper.value = 0
            self.saveNumberTrips(Int(self.stepper.value))
            self.counterLabel.text = "\(Int(self.stepper.value))"
            self.setAverage()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
       cancel in
        })
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        presentViewController(alert, animated: true, completion: nil)
       
    }
    

    func setAverage() {
        var averageValue: Double!
       
        if stepper.value > 0 {
            averageValue = 116.5 / stepper.value
        } else {
            averageValue = 0.00
        }
        averageLabel.text = String(format: "$ %.2f", averageValue)
    }
    
    
    func fetchNumberTrips () {
        
        let fetchRequest = NSFetchRequest(entityName:"TripCounter")
        fetchRequest.fetchLimit = 1
        let fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [TripCounter]
        
        if let result = fetchedResults.first {
            stepper.value = Double(result.numberTrips)
        } else {
            createEntity ()
        }
       
        println(fetchedResults)

    }
    
    func saveNumberTrips (numberTripsPassed: Int){
        
        let fetchRequest = NSFetchRequest(entityName:"TripCounter")
        fetchRequest.fetchLimit = 1
        let fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [TripCounter]
        
        fetchedResults.first!.numberTrips = numberTripsPassed
        
        managedObjectContext.save(nil)
        
        println(fetchedResults)

    }
    
    func createEntity () {
        let newEntity = NSEntityDescription.insertNewObjectForEntityForName("TripCounter", inManagedObjectContext: self.managedObjectContext) as! TripCounter
        
        self.managedObjectContext.save(nil)
    }
}
