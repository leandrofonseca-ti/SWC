//
//  ExtraTaskListVC.swift
//  SWC
//
//  Created by Leandro Fonseca on 21/01/18.
//  Copyright © 2018 LF. All rights reserved.
//


import UIKit

class ExtraTaskListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var list: Array<Tasks> = Array()
    
    @IBOutlet var tbViewItems: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        LoadExtraTasks()
        // Do any additional setup after loading the view.
    }
    
    
    public func LoadExtraTasks()
    {
       self.list =  ScheduleService.LoadExtraTaskItems()
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        self.revealViewController().revealToggle(animated: true)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbViewItems.dequeueReusableCell(withIdentifier: "cell") as! ExtraTaskTableViewCell
        
        let data = list[indexPath.row] as Tasks
        cell.txtDesc.text =  data.FULL
        cell.ID = data.ID
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        /*
         let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
         
         self.list.remove(at: indexPath.row)
         self.tbViewItems.reloadData()
         }*/
        
        let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailScheduleStaffVC") as! DetailScheduleStaffVC
            
            nextViewController.ID =  self.list[indexPath.row].ID
            nextViewController.SCHEDULE_NAME = self.list[indexPath.row].NAME
            
            
            self.present(nextViewController, animated:true, completion:nil)
            
            
        }
        
        share.backgroundColor = UIColor.blue
        
        return [share]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
