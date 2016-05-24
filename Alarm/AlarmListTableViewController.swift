//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Eva Marie Bresciano on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedController.alarms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("switchTableViewCell", forIndexPath: indexPath) as? SwitchTableViewCell
        let alarm = AlarmController.sharedController.alarms[indexPath.row]
        cell?.updateWithAlarm(alarm)

        // Configure the cell...

        return cell ?? UITableViewCell()
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let alarm = AlarmController.sharedController.alarms[indexPath.row]
            AlarmController.sharedController.deleteAlarm(alarm)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailSegue" {
        let alarmDVC = segue.destinationViewController as? AlarmDetailTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            let alarm = AlarmController.sharedController.alarms[indexPath.row]
            alarmDVC?.alarm = alarm
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        }
    }
}
