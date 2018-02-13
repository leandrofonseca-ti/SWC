//
//  ModalTaskController.swift
//  SWC
//
//  Created by Leandro Fonseca on 26/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit
import JModalController

class ModalExtraTaskController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var delegate : JModalDelegate?
    var choices: Array<Tasks> = Array()
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
        cell.textLabel?.text = choices[(indexPath as NSIndexPath).row].FULL
        return cell
    }
    
    
    //func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choices[(indexPath as NSIndexPath).row].QUANTITY = 1
         self.delegate!.dismissModal(self, data: choices[(indexPath as NSIndexPath).row])
    }
    
        
    @IBAction func dismiss(_ sender: Any) {
        self.delegate!.dismissModal(self, data: nil)
    }
}
