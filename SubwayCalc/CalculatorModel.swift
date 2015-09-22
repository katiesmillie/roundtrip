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
        let valueNeeded = rides * subwayFare
        var amountToAdd = (valueNeeded - cardValue) / 1.11
        amountToAdd = round(amountToAdd * 100.0)
        amountToAdd = amountToAdd / 100.0
        return amountToAdd
    }
    
    func calcAmountNeededFromAmountToAdd(amountsToAdd: [Double]) -> [Double] {
        var amountsNeeded = [Double]()
        for amountToAdd in amountsToAdd {
            let amountNeeded = (round(amountToAdd * 1.11 * 100) / 100) + cardValue
            amountsNeeded.append(amountNeeded)
        }
        print(amountsNeeded)
        return amountsNeeded
    }
    
    func calcBonus(amountsToAdd: [Double]) -> [Double] {
        var bonusPcts = [Double]()
        for amountToAdd in amountsToAdd {
            let bonusPct =  amountToAdd * 0.11
            bonusPcts.append(bonusPct)
        }
        return bonusPcts
    }
    
    func calcNumberRides (amountsToAdd: [Double]) -> [Double]{
        var numberRides = [Double]()
        for amountToAdd in amountsToAdd {
            let ride = round(((amountToAdd * 1.11) + cardValue) / subwayFare)
            numberRides.append(ride)
        }
        return numberRides
    }

    func calcAmountsArray() -> [Double]{
        var amountsToAdd = [Double]()
        for var rides = 4.0; rides <= 99; ++rides {
            let amountToAdd = calcAmountToAdd(rides)
            amountsToAdd.append(amountToAdd)
        }
        let suggestedAmts = findSuggestedAmounts(amountsToAdd)
        return suggestedAmts
    }
    
    func findSuggestedAmounts(amounts: [Double]) -> [Double] {
        var suggestedAmts = [Double]()
        for amountToAdd in amounts {
            let multipliedAmount = (amountToAdd  * 1000.0) / 10
            print(multipliedAmount)
            print(amountToAdd)
            if multipliedAmount % 5 == 0 && amountToAdd >= 5.50 && round(multipliedAmount * 1.11) % 5 == 0 {
                print(amountToAdd)
                suggestedAmts.append(amountToAdd)
            }
        }
        return suggestedAmts
    }
}