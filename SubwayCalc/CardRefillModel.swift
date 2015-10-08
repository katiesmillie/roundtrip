//
//  CardRefillModel.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 9/22/15.
//  Copyright © 2015 Katie Smillie. All rights reserved.
//

import Foundation

class CardRefillModel {
    
    let initialAmountOnCard: Double
    let numberOfRides: Int
    let subwayFare: Double = 2.75
    
    
    init (initialAmountOnCard: Double, numberOfRides: Int){
        self.initialAmountOnCard = initialAmountOnCard
        self.numberOfRides = numberOfRides
    }
    
    func finalCardValue() -> Double {
        return Double(numberOfRides) * subwayFare
    }
    
    func totalAmountNeeded() -> Double {
        return self.finalCardValue() - initialAmountOnCard
    }
    
    /** This is the amount needed divided 1.11 to account for the MTA bonus of 11% */
   func amountToPutInMachine() -> Double {
        return self.roundTo100s(self.totalAmountNeeded() / 1.11)
    }
    
    func bonus() -> Double {
        return self.roundTo100s(self.amountToPutInMachine() * 0.11)
    }
    
    func isValid() -> Bool {
        if self.needsEnoughMoney() && self.isDivisibleBy5Cents() && self.isNotGreaterThanOneHundred() {
            return true
        }
        return false
    }
    
    private func needsEnoughMoney() -> Bool {
        return self.amountToPutInMachine() >= 5.5
    }
    
    private func isDivisibleBy5Cents() -> Bool {
        return (self.amountToPutInMachine() * 100) % 5 == 0
    }
    
    private func isNotGreaterThanOneHundred() -> Bool {
        return (self.finalCardValue() <= 100.0)
    }
    
    private func roundTo100s(number: Double) -> Double {
        return round(100 * number) / 100
    }
    
    
    
    
}