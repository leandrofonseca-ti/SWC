//
//  DetailTableViewCell.swift
//  SWC
//
//  Created by Leandro Fonseca on 15/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit

class StaffTableViewCell: UITableViewCell {

    var ID = 0
    @IBOutlet var txtDesc: UILabel!
    @IBOutlet var txtStatus: UILabel!
    @IBOutlet var txtText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
