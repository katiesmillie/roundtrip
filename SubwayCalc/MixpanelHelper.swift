//
//  Mixpanel.swift
//
//  Created by Katie Smillie on 2/26/16.
//
//

import UIKit
import Mixpanel

struct MixpanelHelper {
    
    let mixpanelToken = "1720546449118785aaf2b7e159264e73"
    
    func setup() {
        Mixpanel.initialize(token: mixpanelToken)
        people()
    }
    
    func track(_ event: String, properties: Properties? = nil) {
        Mixpanel.mainInstance().track(event: event, properties: properties)
    }
    
    func people() {
        let dateNow = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let dateString = formatter.string(from: dateNow)
        Mixpanel.mainInstance().people.setOnce(properties: ["$created": dateString])
    }
    
}
