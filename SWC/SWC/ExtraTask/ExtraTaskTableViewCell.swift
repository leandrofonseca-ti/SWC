//
//  ExtraTaskTableViewCell.swift
//  SWC
//
//  Created by Leandro Fonseca on 21/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit

class ExtraTaskTableViewCell: UITableViewCell {
    
    var ID = 0
    @IBOutlet var txtDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
