//
//  Mixpanel.swift
//
//  Created by Katie Smillie on 2/26/16.
//
//

import UIKit
import Mixpanel


public let mixpanelToken = "1720546449118785aaf2b7e159264e73"

public struct MixpanelHelper {
    
    static func setup() {
        Mixpanel.sharedInstanceWithToken(mixpanelToken)
        MixpanelHelper.people()
    }
    
    static func track(event: String, properties: [String: AnyObject]?) {
        let mixpanel = Mixpanel.sharedInstanceWithToken(mixpanelToken)
        mixpanel.track(
            event,
            properties: properties
        )
    }
    
    // TODO: Can only use people profiles with registered users
    static func people() {
        let mixpanel = Mixpanel.sharedInstanceWithToken(mixpanelToken)
        
        let dateNow = NSDate()
        // TODO: Move this to a Date Helper class
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let dateString = formatter.stringFromDate(dateNow)
        
        mixpanel.identify(dateString)
        mixpanel.people.setOnce([
            "$created": dateString,
            ])
    }
    
}