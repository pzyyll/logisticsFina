//
//  CorrectTableViewCell.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/19.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class CorrectTableViewCell: UITableViewCell {

    @IBOutlet weak var sd_station: UILabel!
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var contacts: UILabel!
    @IBOutlet weak var releaseOne: UILabel!
    @IBOutlet weak var fee: UILabel!
    
    var orderItem: OrderItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConfig(item: OrderItem) {
        self.sd_station.text = item.org_Station + " → " + item.des_Station
        self.sender.text = item.sender
        self.contact.text = item.phone_num
        self.contacts.text = item.contacts
        self.releaseOne.text = item.publisher
        self.fee.text = "面议"
    }

}
