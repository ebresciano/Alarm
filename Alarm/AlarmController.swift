//
//  AlarmController.swift
//  Alarm
//
//  Created by Eva Marie Bresciano on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmController {
    
    let kAlarms = "alarmKey"
    
    static let sharedController = AlarmController()
    
    var alarms = [Alarm]()
    
    weak var delegate: AlarmScheduler?
    
    
    init() {
        alarms = mockAlarms
        loadFromPersistentStorage()
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
        saveToPersistentStorage()
        return alarm
        
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String){
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
        
    }
    
    func deleteAlarm(alarm: Alarm) {
        if let indexOfAlarm = alarms.indexOf(alarm) {
            alarms.removeAtIndex(indexOfAlarm)
            delegate?.cancelLocalNotification(alarm)
            saveToPersistentStorage()
        }
        
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
        
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: self.filePath(kAlarms))
    }
    
    func loadFromPersistentStorage() {
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(kAlarms)) as? [Alarm] else {return}
        self.alarms = alarms
    }
    
}

protocol AlarmScheduler: class {
    
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
        let localNotification = UILocalNotification()
        localNotification.alertTitle = "ALERT"
        localNotification.alertBody = "SOMETHING IS GOING ON"
        localNotification.category = alarm.uuid
        localNotification.fireDate = NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func cancelLocalNotification(alarm: Alarm) {
        guard let LocalNotification = UIApplication.sharedApplication().scheduledLocalNotifications else {return}
        let specificNotification = LocalNotification.filter({$0.category == alarm.uuid})
        guard let alarmNotification = specificNotification.last else {
            return
        }
        UIApplication.sharedApplication().cancelLocalNotification(alarmNotification)
        
    }
    
}






