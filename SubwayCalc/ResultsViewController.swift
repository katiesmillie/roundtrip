//
//  ResultsViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/12/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cardAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var amountOnCard: Double!
    var suggestedRefillView: UIView!
    var validRefills = [CardRefillModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Suggested Amounts"
        
        cardAmountLabel.text = String(format: "$ %.2f MetroCard", amountOnCard)
        findValidRefills()
    }
    
    func findValidRefills() {
        for rides in 1...37 {
            let refill = CardRefillModel(initialAmountOnCard: amountOnCard, numberOfRides: rides)
            if refill.isValid() == true {
                validRefills.append(refill)
            }
        }
    }

 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return validRefills.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Refill Cell") as UITableViewCell!
        let refill = validRefills[indexPath.row]
        let view = cell.contentView.subviews[0] as! SuggestedRefillView
        
        view.amountToAddLabel.text = String(format: "$ %.2f", refill.amountToPutInMachine())
        view.bonusPercentLabel.text = String(format: "$ %.2f", refill.bonus())
        view.finalCardValueLabel.text = String(format: "$ %.2f", refill.finalCardValue())
        view.numberOfRidesLabel.text = String(refill.numberOfRides)
    
        return cell
    }

    
}
