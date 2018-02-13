//
//  MenuTableViewController.swift
//  SOH
//
//  Created by Leandro Fonseca on 20/07/17.
//  Copyright © 2017 Leandro. All rights reserved.
//

import UIKit

struct cellSectionData{

    let section: Int!
    let text: String!
    let items: Array<cellData>
}

struct cellData{
    let cell: Int!
    let image: UIImage!
    let text: String
    let count: String!
}

class MenuTableViewController: UITableViewController  {

    var arrayOfCellSectionData = [cellSectionData]()
    var profileId = 0
    override func viewDidLoad() {
        super.viewDidLoad()

       
        ReloadMenu()

    }

    
    public func ReloadMenu(){
        let result = GlobalData.IsLogged()
        arrayOfCellSectionData = [cellSectionData]()
        profileId = result.PROFILEID
        
        switch(result.PROFILEID)
        {
      
        case 1: // ADMIN
            break;
        case 2: // PARTNER
        
            let arraySectionEmployee = [cellData(cell : 0, image: UIImage(named: "ic_schedule"), text : "Scheduling" , count: "" ),
                                 cellData(cell : 1, image: UIImage(named: "ic_check_circle"), text : "Check in/out" , count: "" ),
                                 cellData(cell : 2, image: UIImage(named: "ic_chat"), text : "Communication" , count: "" ),
                                 cellData(cell : 3, image: UIImage(named: "ic_settings_backup_restore"), text : "Status Supplies" , count: "" )]
            let sectionEmployee = cellSectionData(section: 0, text: "Partner", items: arraySectionEmployee)
        
            arrayOfCellSectionData.insert(sectionEmployee, at: arrayOfCellSectionData.count)
            break;
            
        case 3: // STAFF
            
            let arraySectionCustomer = [cellData(cell : 0, image: UIImage(named: "ic_schedule"), text : "Scheduling" , count: "" )
                                        ,cellData(cell : 1, image: UIImage(named: "ic_playlist_add"), text : "Extra Task" , count: "" )
                                        //,cellData(cell : 2, image: UIImage(named: "ic_chat"), text : "Communication" , count: "" )
                                        //,cellData(cell : 3, image: UIImage(named: "ic_monetization_on"), text : "Update Payment" , count: "" )
                                        //,cellData(cell : 4, image: UIImage(named: "ic_feedback"), text : "Feedback" , count: "" )
            ]
            
            let sectionCustomer = cellSectionData(section: 0, text: "Staff", items: arraySectionCustomer)
            
            arrayOfCellSectionData.insert(sectionCustomer, at: arrayOfCellSectionData.count)
            
            break;
            
        case 4: // CUSTOMER
            
            let arraySectionCustomer = [cellData(cell : 0, image: UIImage(named: "ic_schedule"), text : "Scheduling" , count: "" )
                                        ,cellData(cell : 1, image: UIImage(named: "ic_playlist_add"), text : "Extra Task" , count: "" )
                                        ,cellData(cell : 2, image: UIImage(named: "ic_date_range"), text : "Calendar" , count: "" )
                
                                       // ,cellData(cell : 2, image: UIImage(named: "ic_chat"), text : "Communication" , count: "" )
                                        //,cellData(cell : 4, image: UIImage(named: "ic_feedback"), text : "Feedback" , count: "" )
            ]
            
            let sectionCustomer = cellSectionData(section: 0, text: "Customer", items: arraySectionCustomer)
            
            arrayOfCellSectionData.insert(sectionCustomer, at: arrayOfCellSectionData.count)
            
            break;
        default:
            break;
        }
        
      
        
        let arraySectionAbout = [cellData(cell : 0, image: UIImage(named: "ic_store"), text : "Smart Way" , count: "" ),
                             cellData(cell : 1, image: UIImage(named: "ic_email"), text : "Contact" , count: "" ),
                            // cellData(cell : 2, image: UIImage(named: "ic_help_outline"), text : "Help" , count: "" ),
                             cellData(cell : 3, image: UIImage(named: "ic_exit_to_app"), text : "Sign out" , count: "" )]
        
        let sectionAbout = cellSectionData(section: 1, text: "About", items: arraySectionAbout)
        
        arrayOfCellSectionData.insert(sectionAbout, at: arrayOfCellSectionData.count)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuCell
        
        cell.lblMenuName.text = arrayOfCellSectionData[indexPath.section].items[indexPath.row].text
        cell.lblCount.text = arrayOfCellSectionData[indexPath.section].items[indexPath.row].count
        cell.imgIcon.image = arrayOfCellSectionData[indexPath.section].items[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellSectionData[section].items.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfCellSectionData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayOfCellSectionData[section].text
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.textColor = UIColor.lightGray
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
        
        if(indexPath.section == 0) //
        {
        if(profileId == 4) // CUSTOMER
        {
            switch indexPath.row {
            case 0:
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ScheduleCustomerListVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
                break
            case 1:
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ExtraTaskListVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
                break
                
            case 2:
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "CalendarVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
                break
                
            case 3:
                print("3")
                break
                
            default:
                print("4")
                break
            }
        }
         if(profileId == 3) // STAFF
         {
            switch indexPath.row {
            case 0:
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ScheduleStaffListVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)

                break
            case 1:
                print("1")
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ExtraTaskListVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
                break
                
            case 3:
                print("3")
                break

            default:
                print("4")
                break
            }
        }
        }
        

        if(indexPath.section == 1) // SOBRE
        {
            
            switch indexPath.item {
            case 0: // SWC
    
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AboutVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
            
                break
            case 1: // CONTATO
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ContactVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                break
          /*  case 2: // AJUDA
                let revealviewcontroller:SWRevealViewController = self.revealViewController()
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "HelpVC")
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
                break*/
            case 2: // SAIR
                
                GlobalData.Logout()
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewStart") as! ViewController
                self.present(nextViewController, animated:true, completion:nil)
                break;
                
            default:
                break;
            }

          
        }
        
        
    }
   
}
