//
//  CardRefillModel.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 9/22/15.
//  Copyright © 2015 Katie Smillie. All rights reserved.
//

import Foundation

public class CardRefillModel {
    let initialAmountOnCard: Float
    let numberOfRides: Int
    let subwayFare: Float = 2.75
    
    
    init (initialAmountOnCard: Float, numberOfRides: Int){
        self.initialAmountOnCard = initialAmountOnCard
        self.numberOfRides = numberOfRides
    }
    
    func finalCardValue() -> Float {
        return Float(numberOfRides) * subwayFare
    }
    
    func totalAmountNeeded() -> Float {
        return self.finalCardValue() - initialAmountOnCard
    }
    
    /** This is the amount needed divided 1.11 to account for the MTA bonus of 11% */
   func amountToPutInMachine() -> Float {
        return self.roundTo100s(self.totalAmountNeeded() / 1.11)
    }
    
    func bonus() -> Float {
        return self.roundTo100s(self.amountToPutInMachine() * 0.11)
    }
    
    func isValid() -> Bool {
        if self.needsEnoughMoney() && self.isDivisibleBy5Cents() {
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
    
    private func roundTo100s(number: Float) -> Float {
        return round(100 * number) / 100
    }
    
    
    
    
}