//
//  TripLog.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 8/1/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import Foundation
import CoreData

class TripLog: NSManagedObject {
    
    @NSManaged var dateTime: Date
    @NSManaged var subwayLine: String
    @NSManaged var name: String
    @NSManaged var month: Int
    @NSManaged var day: Int
    @NSManaged var year: Int

}
