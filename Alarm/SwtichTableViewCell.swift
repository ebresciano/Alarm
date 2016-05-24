//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Eva Marie Bresciano on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var alarmSwitch: UISwitch!
    
    func updateWithAlarm(alarm: Alarm) {
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.on = alarm.enabled
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate?.switchValueChanged(self, selected: alarmSwitch.on)
    
    }

}

protocol SwitchTableViewCellDelegate: class {
    func switchValueChanged(cell: SwitchTableViewCell, selected: Bool)
}

