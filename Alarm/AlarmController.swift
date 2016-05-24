//
//  AlarmController.swift
//  Alarm
//
//  Created by Eva Marie Bresciano on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedController = AlarmController()
    
    var alarms = [Alarm]()
    
    init() {
        alarms = mockAlarms
    }
    
    var mockAlarms: [Alarm] {
        let wakeUpAlarm = Alarm(fireTimeFromMidnight: 0700, name: "Wake Up Alarm")
        let schoolAlarm = Alarm(fireTimeFromMidnight: 2200, name: "School Alarm")
        let breakAlarm = Alarm(fireTimeFromMidnight: 8000, name: "Break Alarm")
        return [wakeUpAlarm, schoolAlarm, breakAlarm]
        
      }
    

    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
    let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        return alarm
    
    
    }

    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String){
    alarm.fireTimeFromMidnight = fireTimeFromMidnight
    alarm.name = name
    
    }

    func deleteAlarm(alarm: Alarm) {
    if let indexOfAlarm = alarms.indexOf(alarm) {
        alarms.removeAtIndex(indexOfAlarm)
    }
    
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        
        
    }
    
    
    }


