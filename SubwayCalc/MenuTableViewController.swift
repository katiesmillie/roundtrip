//
//  MenuTableViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 3/28/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

public enum MenuRow {
    case TripLogger
    case FareCalculator
    case Estimator
    case About
}

class MenuTableViewController: UITableViewController {
    
    let rows: [MenuRow] = [.TripLogger, .FareCalculator, .Estimator, .About]
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func row(indexPath: NSIndexPath) -> MenuRow {
            return rows[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch row(indexPath) {
        case .TripLogger:
            let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuTableViewCell
            cell.menuItemLabel?.text = "Trip Logger"
            return cell
        case .FareCalculator:
            let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuTableViewCell
            cell.menuItemLabel?.text = "Fare Calculator"
            return cell
        case .Estimator:
            let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuTableViewCell
            cell.menuItemLabel?.text = "Monthly Ride Estimator"
            return cell
        case .About:
            let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuTableViewCell
            cell.menuItemLabel?.text = "About RoundTrip"
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch row(indexPath) {
        case .TripLogger:       rootViewController()?.showMainUI()
        case .FareCalculator:   rootViewController()?.showCalculator()
        case .Estimator:        rootViewController()?.showEstimator()
        case .About:            rootViewController()?.showAbout()

        }
    }

    @IBAction func close(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
