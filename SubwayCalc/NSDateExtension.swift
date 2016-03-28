//
//  NSDateExtension.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 3/1/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

extension NSDate {
    
    public func allDateComponents(calendar: NSCalendar = NSCalendar.currentCalendar()) -> NSDateComponents {
        let units: NSCalendarUnit = [.Minute, .Hour, .Day, .Month, .Year, .WeekOfYear, .Weekday]
        return calendar.components(units, fromDate: self)
    }
    
    public func minute() -> Int {
        return allDateComponents().minute
    }
    
    public func hour() -> Int {
        return allDateComponents().hour
    }
    
    public func day() -> Int {
        return allDateComponents().day
    }
    
    public func month() -> Int {
        return allDateComponents().month
    }
    
    public func year() -> Int {
        return allDateComponents().year
    }
    
    public func weekday() -> Int {
        return allDateComponents().weekday
    }


    
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    if rhs.year() < lhs.year() {
        return true
    } else if rhs.year() == lhs.year() && rhs.month() < lhs.month() {
        return true
    } else if rhs.year() == lhs.year() && rhs.month() == lhs.month() && rhs.day() < lhs.day() {
        return true
    } else {
        return false
    }
}

