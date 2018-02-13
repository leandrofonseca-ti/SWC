//
//  ModalCreateAccountController.swift
//  SWC
//
//  Created by Leandro Fonseca on 30/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit
import JModalController

class ModalCreateAccountController: UIViewController , MaskedTextFieldDelegateListener  {
    
   
    var maskedDelegate: MaskedTextFieldDelegate!
    var language: String = "US"
    var delegate : JModalDelegate?
    
   
    @IBOutlet var languageSegment: UISegmentedControl!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtLastname: UITextField!
    @IBOutlet var txtName: UITextField!
    var selected: Tasks? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBtnCreate()
        
        maskedDelegate = MaskedTextFieldDelegate(format: "+1 ([099]) [00000]-[00009]")
        maskedDelegate.listener = self
        
        txtPhone.delegate = maskedDelegate
    }
  
    @IBAction func changeCountry(_ sender: UISegmentedControl) {
        
        if( languageSegment.selectedSegmentIndex == 0)
        {
            language = "US"
            maskedDelegate = MaskedTextFieldDelegate(format: "+1 ([099]) [00000]-[00009]")
            maskedDelegate.listener = self
            txtPhone.delegate = maskedDelegate
            
            txtPhone.text = txtPhone.text?.replacingOccurrences(of: "+55", with: "+1")
        }
        else{
            language = "BR"
            maskedDelegate = MaskedTextFieldDelegate(format: "+55 ([00]) [00000]-[00009]")
            maskedDelegate.listener = self
            
            txtPhone.delegate = maskedDelegate
            txtPhone.text = txtPhone.text?.replacingOccurrences(of: "+1", with: "+55")
        }
    }
    
    func addBtnCreate()
    {
        
       
        let button = UIButton(frame: CGRect(x:10,y: self.view.bounds.height - 70, width: self.view.bounds.width - 20, height: 50))
        
        button.backgroundColor =  UIColor.black
        button.setTitle("Save", for: .normal)
        
        button.addTarget(self, action: #selector(pressButtonCreate(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    
    func setErrorTxt(txt: UITextField){
        
        txt.layer.masksToBounds = true
        txt.layer.borderColor = UIColor.red.cgColor
        txt.layer.borderWidth = CGFloat(1)
        
    }
    
    func validarPost() -> String{
        
        var msgErro: String = ""
        
        if txtName.text == "" {
            setErrorTxt(txt: self.txtName)
            msgErro = "Name required"
        } else if txtLastname.text == "" {
            setErrorTxt(txt: txtLastname)
            msgErro = "Lastname required"
        }else if txtEmail.text == "" {
            setErrorTxt(txt: txtEmail)
            msgErro = "E-mail required"
        } else if txtPhone.text == "" {
            setErrorTxt(txt: txtPhone)
            msgErro = "Phone Number required"
        } else if txtPassword.text == "" {
            setErrorTxt(txt: txtPassword)
            msgErro = "Password required"
        }
        
        return msgErro
    }
    
    
    
    func pressButtonCreate(button: UIButton) {
        let msgErro = validarPost()
        
        if msgErro == ""
        {
            
            UserService.CreateAccount(txtName.text!,txtLastname.text! ,txtEmail.text!, txtPhone.text!, txtPassword.text!, completion:{(success, message) -> Void in
                if(success){
                    OperationQueue.main.addOperation {
                        OperationQueue.main.addOperation {
                            let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                else{
                    OperationQueue.main.addOperation {
                        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
            
            self.delegate!.dismissModal(self, data: nil)
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
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.delegate!.dismissModal(self, data: nil)
    }
}
