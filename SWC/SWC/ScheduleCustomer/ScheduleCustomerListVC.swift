//
//  ScheduleCustomerListVC.swift
//  SWC
//
//  Created by Leandro Fonseca on 21/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit

class ScheduleCustomerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tbview: UITableView!
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
    
    @IBAction func clickAdd(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateScheduleCustomer1VC") as! CreateScheduleCustomer1VC
        
        
        nextViewController.loadAllData()
        
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        self.revealViewController().revealToggle(animated: true)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbview.dequeueReusableCell(withIdentifier: "cell") as! CustomerTableViewCell
        
        let data = list[indexPath.row] as Schedule
        cell.lblTitle.text =  data.NAME
        cell.lblStatus.text =  "\(data.STATUS)"
        cell.lblDescription.text =  "Status: \(data.STATUS) | Period Type: \(data.TYPE)"
        cell.ID = data.ID
        return cell
        
    }
    /*
     public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
     {
     if (editingStyle == UITableViewCellEditingStyle.delete)
     {
     list.remove(at: indexPath.row)
     tbview.reloadData()
     }
     
     //if( editingStyle == UITableViewCellEditingStyle)
     //{
     
     //}
     }
     */
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.list.remove(at: indexPath.row)
            self.tbview.reloadData()
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
            //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            //let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailScheduleCustomerVC") as! DetailScheduleCustomerVC
            
            //nextViewController.ID =  self.list[indexPath.row].ID
            //nextViewController.SCHEDULE_NAME = self.list[indexPath.row].NAME
            
            //self.present(nextViewController, animated:true, completion:nil)
            
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateScheduleCustomer1VC") as! CreateScheduleCustomer1VC
            
            nextViewController.ID =  self.list[indexPath.row].ID
            nextViewController.SCHEDULENAME = self.list[indexPath.row].NAME
            nextViewController.loadAllData()
            
            self.present(nextViewController, animated:true, completion:nil)
            
            
        }
        
        share.backgroundColor = UIColor.blue
        
        return [delete, share]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
