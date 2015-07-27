//
//  CalculatorModel.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/12/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    let cardValue: Double
    let subwayFare = 2.75
   
    init(cardValue: Double) {
        self.cardValue = cardValue
    }

    
    func calcAmountToAdd(rides: Double) -> Double {
        var valueNeeded = rides * subwayFare
        return (valueNeeded - cardValue) / 1.11
    }
    
    
    func calcAmountNeededFromAmountToAdd(amountsToAdd: Array<Double>) -> Array<Double> {
        var amountsNeeded = [Double]()
        for amountToAdd in amountsToAdd {
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)
            var amountNeeded = round(((amountToAdd * 1.11) * multiplier) / multiplier + cardValue)
            amountsNeeded.append(amountNeeded)
        }
        return amountsNeeded
    }
    
    func calcBonus(amountsToAdd: Array<Double>) -> Array<Double> {
        var bonusPcts = [Double]()
        for amountToAdd in amountsToAdd {
            var bonusPct =  amountToAdd * 0.11
            bonusPcts.append(bonusPct)
        }
        return bonusPcts
    }
    
    func calcNumberRides (amountsToAdd: Array<Double>) -> Array<Double> {
        var numberRides = [Double]()
        for amountToAdd in amountsToAdd {
            var ride =  (amountToAdd * 1.11) + cardValue / subwayFare
            numberRides.append(ride)
        }
        return numberRides
}


    func calcAmountsArray() -> [Double]{
        var amountsToAdd = [Double]()
        for var rides = 4.0; rides <= 99; ++rides {
            var amountToAdd = Double(calcAmountToAdd(rides))
                
        // ------- need to double check what rounding rules MTA uses
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)
            amountToAdd = round(amountToAdd * multiplier)/multiplier
            amountsToAdd.append(amountToAdd)
        }
        var suggestedAmts = findSuggestedAmounts(amountsToAdd)
        return suggestedAmts
    }
    
    
    func findSuggestedAmounts(amounts: [Double]) -> [Double] {
        var suggestedAmts = [Double]()
        for amountToAdd in amounts {
            let multipliedAmount = amountToAdd * 100
            if multipliedAmount % 5 == 0 && amountToAdd >= 5.50 {
            suggestedAmts.append(amountToAdd)
            }
        }
        return suggestedAmts
    }
    
}