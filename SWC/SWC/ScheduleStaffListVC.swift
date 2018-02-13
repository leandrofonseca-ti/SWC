//
//  ScheduleStaffListVC.swift
//  SWC
//
//  Created by Leandro Fonseca on 21/01/18.
//  Copyright © 2018 LF. All rights reserved.
//
import UIKit

class ScheduleStaffListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet var tbViewItems: UITableView!
    var list: Array<Schedule> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        LoadSchedule()
        // Do any additional setup after loading the view.
    }
    
    
    public func LoadSchedule()
    {
        self.list = ScheduleService.LoadScheduleByUser() 
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        self.revealViewController().revealToggle(animated: true)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbViewItems.dequeueReusableCell(withIdentifier: "cell") as! StaffTableViewCell
        
        let data = list[indexPath.row] as Schedule
        cell.txtDesc.text =  data.NAME
        cell.txtStatus.text =  "\(data.STATUS)"
        cell.txtText.text =  "\(data.ID) | \(data.STATUS) | \(data.TYPE)"
        cell.ID = data.ID
        
        
       // let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
       // let data = list[indexPath.row] as Schedule
        
        //cell.textLabel?.text = data.NAME
        
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
