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
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        stepCount = NSNumber()
        distance = NSNumber()
    }
    
    func formatDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: startDate)
        
    }
    
}
