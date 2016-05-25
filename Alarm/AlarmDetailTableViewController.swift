//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Eva Marie Bresciano on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var disableButton: UIButton!
    
    var alarm: Alarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarm = alarm {
        updateWithAlarm(alarm)
        }
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func disableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else {
            return }
            AlarmController.sharedController.toggleEnabled(alarm)
        if alarm.enabled {
            scheduleLocalNotification(alarm)
        } else {
            cancelLocalNotification(alarm)
        }
        setUpView()
        }

    @IBAction func saveTappedButton(sender: AnyObject) {
        guard let title = textField.text,
        thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
            let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
            if let alarm = alarm {
                AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
                cancelLocalNotification(alarm)
                scheduleLocalNotification(alarm)
                } else {
                let alarm = AlarmController.sharedController.addAlarm(timeIntervalSinceMidnight, name: title)
                scheduleLocalNotification(alarm)
                self.alarm = alarm }
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    
    func updateWithAlarm(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return
        }
        textField.text = alarm.name
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false)
        
}
    
    func setUpView() {
        if self.alarm == nil {
            disableButton.hidden = true} else {
            disableButton.hidden = false
            if alarm?.enabled == true {
                disableButton.setTitle("Disable", forState: .Normal)
                disableButton.setTitleColor(.whiteColor(), forState: .Normal)
                disableButton.backgroundColor = .redColor()
            } else {
                disableButton.setTitle("Enable", forState: .Normal)
                disableButton.setTitleColor(.blueColor(), forState: .Normal)
                disableButton.backgroundColor = .grayColor()
            }
        
        }
    }
    
    // MARK: - Table view data source


   /* override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 */

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
