//
//  PromotionModel.swift
//  MIXR
//
//  Created by Michael Ciesielka on 9/21/16.
//  Copyright © 2016 MIXR LLC. All rights reserved.
//

import Foundation

class PromotionModel {
    let status: String
    let timestamp: NSTimeInterval
    
    private let sourceData: [String: String]!
    
    init(object: [String: String]) {
        sourceData = object
        
        status = object["promoters"] ?? ""
        
        if let hrString = object["userHr"],
            let intHr = Int(hrString) {
            timestamp = NSTimeInterval(intHr)
        } else {
            // should never get here
            timestamp = NSDate().timeIntervalSince1970 - 60*3
        }
    }
    
    var priceLabel: String? {
        return nil
    }
    
    var timeUntilExpirationString: String? {
        return nil
    }
    
    var expirationDateString: String? {
        return nil
    }
    
    var imageURLString: String? {
        return nil
    }
    
    var description: String? {
        return nil
    }
}
