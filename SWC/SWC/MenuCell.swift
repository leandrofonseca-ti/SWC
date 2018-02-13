//
//  MenuCell.swift
//  SOH
//
//  Created by Leandro Fonseca on 11/05/17.
//  Copyright © 2017 Leandro. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

 
    @IBOutlet var lblCount: UILabel!
    
    @IBOutlet var lblMenuName: UILabel!
    @IBOutlet var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
 

}
