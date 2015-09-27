//
//  CardRefillSpec.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 9/22/15.
//  Copyright © 2015 Katie Smillie. All rights reserved.
//

import Quick
import Nimble

@testable import SubwayCalc

class CardRefillSpec: QuickSpec {
    override func spec() {
        describe("finalCardValue()") {
            it("should be number of rides * the subway fare") {
                let cardRefill = CardRefillModel(initialAmountOnCard: 1.85, numberOfRides: 4)
                expect(cardRefill.finalCardValue()).to(equal(11.0))
            }
        }
        
        describe("totalAmountNeeded()") {
            it("should be the final card value - initialFare") {
                let cardRefill = CardRefillModel(initialAmountOnCard: 1.85, numberOfRides: 4)
                expect(cardRefill.totalAmountNeeded()).to(equal(9.15))
            }
        }
        
        describe("amountToPutInMachine()") {
            it("should be the totalAmountNeeded() / $1.11") {
                let cardRefill = CardRefillModel(initialAmountOnCard: 1.85, numberOfRides: 4)
                expect(cardRefill.amountToPutInMachine()).to(equal(8.24))
            }
        }
        
        describe("bonus") {
            it("should be 11% of the amountToPutInMachine") {
                let cardRefill = CardRefillModel(initialAmountOnCard: 1.85, numberOfRides: 4)
                expect(cardRefill.bonus()).to(equal(0.91))
            }
        }
        
        describe("isValid") {
            
            context("the amountToPutInMachine() is divisible by $0.05") {
                context("the amountToPutInMachine() is greater than $5.50") {
                    it("should return true") {
                        let cardRefill = CardRefillModel(initialAmountOnCard: 1.85, numberOfRides: 6)
                        expect(cardRefill.isValid()).to(equal(true))
                    }
                }
                
                context("the amountToPutInMachine() is less than $5.50") {
                    it("should return false") {
                        let cardRefill = CardRefillModel(initialAmountOnCard: 1.86, numberOfRides: 1)
                        expect(cardRefill.isValid()).to(equal(false))
                    }
                }
            }
            
            context("the amountToPutInMachine() is divisible by .05") {
                it("should return false") {
                    let cardRefill = CardRefillModel(initialAmountOnCard: 1.85, numberOfRides: 4)
                    expect(cardRefill.isValid()).to(equal(false))
                }
            }
        }
    }
}