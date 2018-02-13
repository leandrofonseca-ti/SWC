//
//  CreateScheduleCustomer1VC.swift
//  SWC
//
//  Created by Leandro Fonseca on 28/01/18.
//  Copyright © 2018 LF. All rights reserved.
//


import UIKit
import JModalController

class CreateScheduleCustomer1VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTaskDelegate {
    
    
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var titleLabel:UILabel?
    @IBOutlet var nav: UINavigationItem!
    
    var ID = 0
    var ENTITY = ScheduleItem()
    var SCHEDULEID = 0
    var SCHEDULENAME = ""
    var PLANNAME = ""
    
    @IBOutlet var vwDropTaskPlan: UIView!
    @IBOutlet var vwDropSchedule: UIView!
    
    @IBOutlet var lblSchedule: UILabel!
    @IBOutlet var lblPlan: UILabel!
    
    
    
    var listAdded: Array<Tasks> = Array()
    var listExtraTaskAdded: Array<Tasks> = Array()
    
    var listExtraTask: Array<Tasks> = Array()
    
    
    var arrayScheduleItems: Array<Schedule> = Array()
    var arrayPlanItems: Array<Plan> = Array()
    
    @IBOutlet var tbView: UITableView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        addbuttonfloatOK()
       
        
        lblSchedule.text = SCHEDULENAME
        
        nav.title = "Create Schedule"
        if ID > 0 {
            nav.title = "Edit Schedule"
        }
    }
    
    
    func loadAllData()
    {
        loadPlanTask()
        loadExtraTasksModal()
        loadSchedule()
        
        if  self.arrayScheduleItems.count == 1 {
            SCHEDULEID = self.arrayScheduleItems[0].ID
            SCHEDULENAME = self.arrayScheduleItems[0].NAME
        }
        if ID > 0 {
            loadScheduleItem(ID)
        }
    }
    
    private func loadScheduleItem(_ code: Int){
     
        ScheduleService.LoadScheduleItem(id: code, completion:{(success, result) -> Void in
            if(success){
                OperationQueue.main.addOperation {
                    
                      self.ENTITY = result
                      self.ID = code
                    
                      self.SCHEDULEID = result.ID
                      self.SCHEDULENAME = result.SCHEDULE_NAME
                      self.PLANNAME = result.PLAN_NAME
                    
                      self.lblSchedule.text = result.SCHEDULE_NAME
                      self.lblPlan.text = result.PLAN_NAME
                    
                    
                    for item in result.TASKS
                    {
                        if item.EXTRA{
                            self.listExtraTaskAdded.append(item)
                        }
                        self.listAdded.append(item)
                    }
                    
                    
                    
                    
                   // ImageURLs.insert(url, at: ImageURLs.count)
                    
                }
            }
        })
    }
    
    private func loadExtraTasksModal()
    {
        let objs = ScheduleService.LoadExtraTaskItems()
        for item in objs {
            self.listExtraTask.append(item)
        }
    }
    
    private func loadSchedule()
    {
        let objs = ScheduleService.LoadScheduleByUser()
        for item in objs {
            self.arrayScheduleItems.append(item)
        }
    }
    
    private func loadPlanTask()
    {
        let objs = ScheduleService.LoadPlanTaskItems()
        for item in objs {
            self.arrayPlanItems.append(item)
        }
    }
    
    @IBAction func clickPlanSelected(_ sender: Any) {
        
        var arraySelect : [String] = []
        for item in  self.arrayPlanItems
        {
            arraySelect.append(item.NAME)
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        _ = { (action: UIAlertAction!) -> Void in
            let index = alert.actions.index(of: action)
            
            if index != nil {
                NSLog("Index: \(index!)")
            }
        }
        for item in arraySelect {
            alert.addAction(UIAlertAction(title: item, style: .default, handler: {
                (_) in
                
                self.setPlanName(text: item)
            }
            ))
            
        }
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in }))
        
        self.present(alert, animated: false, completion: nil)
        
        
        
        
    }
    
    
    
    
    
    func setPlanName(text: String)
    {
        self.PLANNAME = text
        self.lblPlan.text = text
        
        let objs = ScheduleService.LoadPlanTaskItemsByPlan(plan: text)
    
        self.listAdded.removeAll()
        
        self.listAdded = objs
        
        for newer in listExtraTaskAdded
        {
            self.listAdded.append(newer)
        }
        
        self.tbView.reloadData()
    }
    
    
    @IBAction func clickAddExtraTask(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let simpleVC = storyBoard.instantiateViewController(withIdentifier: "ModalExtraTaskController") as! ModalExtraTaskController
        
        simpleVC.choices =  self.listExtraTask
        simpleVC.delegate = self
        let config = JModalConfig(transitionDirection: .bottom, animationDuration: 0.2, backgroundTransform: true, tapOverlayDismiss: true)
        presentModal(self, modalViewController: simpleVC, config: config) {
            //print("Presented Simple Modal")
        }
        
        
    }
    
    
    
    func addbuttonfloatOK()
    {
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: self.view.bounds.width - 20, height: 50))
        
        button.backgroundColor =  UIColor.uicolorFromHex(0x4794FE, alpha: 1)
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        
        
        let viewBottom = UIView(frame: CGRect(x:0,y: self.view.bounds.height - 70, width: self.view.bounds.width, height: 100))
        viewBottom.layer.backgroundColor = UIColor.white.cgColor
        viewBottom.addSubview(button)
        
        self.view.addSubview(viewBottom)
        
        
    }
    
    
    
    func validarPost() -> String{
        
        var msgErro: String = ""
        
        if PLANNAME == "" {
          //  setErrorTxt(txt: self.txtNome)
            msgErro = "Task Plan required"
        }
      
        
        return msgErro
    }
    
    @objc func pressButton(button: UIButton) {
        
        let msgErro = validarPost()
        
        if msgErro == ""
        {
        
            AddSpinner()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateScheduleCustomer2VC") as! CreateScheduleCustomer2VC
            
            if self.ID > 0
            {
                nextViewController.ENTITY =  self.ENTITY
            }
            self.present(nextViewController, animated:true, completion:nil)
            
            /*
            ScheduleService.SaveScheduleStep1(uiview: (self.navigationController?.view)!, nome: self.txtNome.text!, sobrenome: "", email: self.txtEmail.text!, celular: self.txtCelular.text!, senha: self.txtSenha.text!, completion:{(success, result) -> Void in
                if(success){
                    OperationQueue.main.addOperation {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateScheduleCustomer2VC") as! CreateScheduleCustomer2VC
                        
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                    
                    self.activityIndicator.stopAnimating()
                }
                else
                {
                    self.activityIndicator.stopAnimating()
                }
            })
            */
          
        
        
        
        }
        else
        {
            let alert = UIAlertController(title: "Warning", message: msgErro, preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    @IBAction func btnBackDetail(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "cell") as! CustomerDetailTableViewCell
        //let qty =  Int(cell.lblQtd.text!)
        let code = cell.ID
        if(self.listAdded[indexPath.row].EXTRA)
        {
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                // delete item at indexPath
               
                var exists = false
                for item in self.listAdded
                {
                    if( item.ID == code){
                        exists = true
                    }
                }
                
                if exists == false {
                    self.listAdded.remove(at: indexPath.row)
                    self.tbView.reloadData()
                }
                
               
            }
            
            return [delete]
        }
        else
        {
            let share = UITableViewRowAction(style: .normal, title: "Lock") { (action, indexPath) in }
            
            share.backgroundColor = UIColor.blue
            return [share]
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listAdded.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "cell") as! CustomerDetailTableViewCell
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "cell") as! CustomerDetailTableViewCell
        let data = listAdded[indexPath.row] as Tasks
        
        
        if data.EXTRA {
            cell.ID = data.ID
            cell.txtText.text = data.FULL
            if  Int(cell.lblQtd.text!)! <= 1
            {
               // cell.lblQtd.text = "\(data.QUANTITY)"
            }
            
        }else
        {
            cell.ID = data.ID
            cell.txtText.text = data.FULL
            if  Int(cell.lblQtd.text!)! <= 1
           {
           // cell.lblQtd.text = "\(data.QUANTITY)"
            }
        }
        cell.delegate = self
        
        return cell
        
    }
    
    
    func updateTaskDelegate(tsk: Tasks) {
        for i in 0..<listAdded.count
        {
            if listAdded[i].ID == tsk.ID {
                listAdded[i].QUANTITY = tsk.QUANTITY
            }
        }
        tbView.reloadData()
    }
    
    
    override func dismissModal(_ sender: Any, data: Any?) {
        super.dismissModal(sender, data: data)
        
        
        if sender is CustomerDetailTableViewCell, let value = data as? Tasks {
            for i in 0..<listAdded.count
            {
                if listAdded[i].ID == value.ID {
                   listAdded[i].QUANTITY = value.QUANTITY
                }
            }
        }
        
        if sender is ModalExtraTaskController, let value = data as? Tasks {
            
            var exists = false
            for item in listExtraTaskAdded
            {
                if( item.ID == value.ID ){
                    exists = true
                }
            }
            
            if exists == false {
                listExtraTaskAdded.append(value)
                listAdded.append(value)
                self.tbView.reloadData()
            }
            
        }
    }
    
    
    func AddSpinner()
    {
        
        loadingView.frame = CGRect(x: 0, y:0, width: 80, height: view.frame.size.height)
        loadingView.center = self.view.center
        
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height - 100);
        
        titleLabel = UILabel(frame: CGRect(x:0, y:0, width: 50, height: 50))
        titleLabel?.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height - 250);
        
        titleLabel!.text = "1.0"
        titleLabel!.textColor = UIColor.white
        titleLabel!.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        titleLabel!.textAlignment = .center
        titleLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.addSubview(activityIndicator)
        
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
        
    }
    
}

