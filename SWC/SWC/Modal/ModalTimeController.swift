//
//  ModalTimeController.swift
//  SWC
//
//  Created by Leandro Fonseca on 26/01/18.
//  Copyright © 2018 LF. All rights reserved.
//


import UIKit
import JModalController

class ModalTimeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var delegate : JModalDelegate?
    var choices = ["12:00 am","12:30 am","1:00 am","1:30 am","2:00 am","2:30 am","3:00 am","3:30 am","4:00 am","4:30 am","5:00 am","5:30 am","6:00 am","6:30 am","7:00 am","7:30 am","8:00 am","8:30 am","9:00 am","9:30 am","10:00 am","10:30 am","11:00 am","11:30 am","12:00 pm","12:30 pm","1:00 pm","1:30 pm","2:00 pm","2:30 pm","3:00 pm","3:30 pm","4:00 pm","4:30 pm","5:00 pm","5:30 pm","6:00 pm", "7:00 pm","7:30 pm","8:00 pm","8:30 pm","9:00 pm","9:30 pm","10:00 pm","10:30 pm","11:00 pm", "11:30 pm"]
    var selected: Tasks? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = choices[(indexPath as NSIndexPath).row]
        return cell
    }
    
    
    //func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate!.dismissModal(self, data: choices[(indexPath as NSIndexPath).row])
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.delegate!.dismissModal(self, data: nil)
    }
}

