//
//  CustomerTableViewCell.swift
//  SWC
//
//  Created by Leandro Fonseca on 21/01/18.
//  Copyright © 2018 LF. All rights reserved.
//



protocol UpdateTaskDelegate {
    func updateTaskDelegate(tsk: Tasks)
}

class CustomerDetailTableViewCell: UITableViewCell {
    
    var ID = 0
    var delegate: UpdateTaskDelegate?
    @IBOutlet var lblQtd: UILabel!
    @IBOutlet var txtText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        lblQtd.text = "\(Int(sender.value))"
        let tsk = Tasks()
        tsk.ID = self.ID
        tsk.QUANTITY = Int(sender.value)
       self.delegate?.updateTaskDelegate(tsk: tsk)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
