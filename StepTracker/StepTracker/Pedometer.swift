//
//  Pedometer.swift
//  StepTracker
//
//  Created by Forrest Zhao on 6/30/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation
import CoreMotion
import Timepiece


class Pedometer {
    
    let pedometer = CMPedometer()

    var activityHistory = [DailyActivity]()
    
    dynamic var reloadDataRequired = false
    
    func startTrackingSteps() {
        
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = TimeZone.current
        cal.timeZone = timeZone
        
        let midnightOfToday = cal.date(from: comps)!
        
        if CMPedometer.isStepCountingAvailable() {
            
            pedometer.startUpdates(from: midnightOfToday) { (data, error) in
                
                if let data = data {
                    
                    print(data.numberOfSteps)
                    
                } else {
                    
                    if let error = error {
                        
                        print("Error getting data: \(error)")
                        
                    } else {
                        
                        print("Error getting data: unknown")
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func retrieveSteps(forPastXDays days: Int) {
        
        let concurrentQueue: DispatchQueue = DispatchQueue.global()
        
        concurrentQueue.async {
            
            var tempActivities = [DailyActivity]()
            
            concurrentQueue.sync {
                for day in 0...days {
                    
                    // get "x days" from today
                    guard let startDate = Date.today() - day.day else {
                        fatalError("Start date calculation error")
                    }
                    
                    //get "1 day" after startdate
                    guard let  endDate = startDate + 1.day else {
                        fatalError("End date calculation error")
                    }
                    
                    var currDayActivity = DailyActivity(startDate: startDate, endDate: endDate)
                    
                    self.pedometer.queryPedometerData(from: startDate, to: endDate, withHandler: { (data, error) in
                        
                        if let data = data {
                            
                            currDayActivity.stepCount = data.numberOfSteps
                            if let distance = data.distance {
                                currDayActivity.distance = distance
                            } else {
                                currDayActivity.distance = 0
                            }
                            
                            tempActivities.append(currDayActivity)
                            
                        }else {
                            if let error = error {
                                print("Error fetching steps data: \(error.localizedDescription)")
                            } else {
                                print("Error fetching steps data: Unknown error")
                            }
                        }
                    })
                    
                }
                
            }
            
            concurrentQueue.sync {
                self.activityHistory = tempActivities
                self.reloadDataRequired = true
            }
            
        }
        
    }

}
