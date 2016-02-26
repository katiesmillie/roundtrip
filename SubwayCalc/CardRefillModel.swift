//
//  CardRefillModel.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 9/22/15.
//  Copyright © 2015 Katie Smillie. All rights reserved.
//

import Foundation

class CardRefillModel {
    
    public let subwayFare = 2.75
    public let bonusDivisor = 1.11
    public let bonusMultiplier = 0.11
    public let minFareForBonus = 5.50
    public let centIncrement = 5.0
    public let naivePercent = 100.0
    
    let initialAmountOnCard: Double
    let numberOfRides: Int
    
    init (initialAmountOnCard: Double, numberOfRides: Int) {
        self.initialAmountOnCard = initialAmountOnCard
        self.numberOfRides = numberOfRides
    }
    
    func finalCardValue() -> Double {
        return Double(numberOfRides) * subwayFare
    }
    
    func totalAmountNeeded() -> Double {
        return self.finalCardValue() - initialAmountOnCard
    }
    
    // This is the amount needed divided 1.11 to account for the MTA bonus of 11%
   func amountToPutInMachine() -> Double {
        return self.roundTo100s(self.totalAmountNeeded() / bonusDivisor)
    }
    
    func bonus() -> Double {
        return self.roundTo100s(self.amountToPutInMachine() * bonusMultiplier)
    }
    
    func isValid() -> Bool {
        if self.needsEnoughMoney() && self.isDivisibleBy5Cents() && self.isNotGreaterThanOneHundred() {
            return true
        }
        return false
    }
    
    private func needsEnoughMoney() -> Bool {
        return self.amountToPutInMachine() >= minFareForBonus
    }
    
    private func isDivisibleBy5Cents() -> Bool {
        return (self.amountToPutInMachine() * naivePercent % centIncrement == 0)
    }
    
    private func isNotGreaterThanOneHundred() -> Bool {
        return (self.finalCardValue() <= naivePercent)
    }
    
    private func roundTo100s(number: Double) -> Double {
        return round(naivePercent * number) / naivePercent
    }
    
    
}