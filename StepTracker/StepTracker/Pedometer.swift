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

let pedometer = CMPedometer()


class Pedometer: NSObject {

    var activityHistory = [DailyActivity]()
    
    dynamic var reloadDataRequired = false
    
    func retrieveSteps(forPastXDays days: Int) {
        
        if CMPedometer.isStepCountingAvailable() {
            
            let concurrentQueue: DispatchQueue = DispatchQueue.global(qos: .background)
            
            concurrentQueue.async {
                
                var tempActivities = [DailyActivity]()
                let queryGroup = DispatchGroup()
                
                concurrentQueue.sync {
                    
                    for day in 0..<days {
                        
                        // get "x days" from today
                        guard let startDate = Date.today() - day.day else {
                            fatalError("Start date calculation error")
                        }
                        
                        //get "1 day" after startdate
                        guard let  endDate = startDate + 1.day else {
                            fatalError("End date calculation error")
                        }
                        
                        queryGroup.enter()
                        
                        pedometer.queryPedometerData(from: startDate, to: endDate, withHandler: { (data, error) in
                            
                            if let data = data {
                                
                                var currDayActivity = DailyActivity(startDate: startDate, endDate: endDate)
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
                            queryGroup.leave()
                        })
                        
                    }
                    
                }
                
                queryGroup.notify(queue: DispatchQueue.main, execute: {
                    self.activityHistory = tempActivities
                    self.reloadDataRequired = true
                })

            }
            
        }
        else {
            
            print("Step counting not available")
            
        }
        
    }

}
