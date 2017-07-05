//
//  DailyActivity.swift
//  StepTracker
//
//  Created by Forrest Zhao on 6/30/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation
import Timepiece

struct DailyActivity {
    
    var startDate: Date
    var endDate: Date
    var stepCount: NSNumber
    var distance: NSNumber
    var floorsAscended: NSNumber
    var floorsDescended: NSNumber
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        stepCount = NSNumber()
        distance = NSNumber()
        floorsAscended = NSNumber()
        floorsDescended = NSNumber()
    }
    
    func getDateStr() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: startDate)
        
    }
    
    func getStepCountStr() -> String {
        
        return "\(stepCount.intValue)"
        
    }
    
    func getFloorsStr() -> String {
        
        let totalStepCount = floorsAscended.intValue + floorsDescended.intValue
        return "\(totalStepCount)"
        
    }
    
    func getDistanceStr() -> String {
        
        let distanceInMeters = Measurement(value: distance.doubleValue, unit: UnitLength.meters)
        let distanceInMiles = distanceInMeters.converted(to: UnitLength.miles)
        
        return String(format: "%.2f", ceil(distanceInMiles.value*100)/100)
        
    }
    
}
