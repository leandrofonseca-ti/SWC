//
//  CustomerTableViewCell.swift
//  SWC
//
//  Created by Leandro Fonseca on 26/01/18.
//  Copyright © 2018 LF. All rights reserved.
//


class CustomerTableViewCell: UITableViewCell {
    
    
    var ID = 0
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
