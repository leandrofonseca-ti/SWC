//
//  ViewController.swift
//  SWC
//
//  Created by Leandro Fonseca on 18/10/17.
//  Copyright © 2017 LF. All rights reserved.
//

import UIKit
import JModalController

class ViewController: UIViewController, MaskedTextFieldDelegateListener {

    var maskedDelegate: MaskedTextFieldDelegate!
    var language: String = "US"
    @IBOutlet var txtPhoneNumber: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var languageSegment: UISegmentedControl!
 
    
    @IBAction func clickLanguage(_ sender: Any) {
        if( languageSegment.selectedSegmentIndex == 0)
       {
        language = "US"
        maskedDelegate = MaskedTextFieldDelegate(format: "+1 ([099]) [00000]-[00009]")
        maskedDelegate.listener = self
        txtPhoneNumber.delegate = maskedDelegate
        
        txtPhoneNumber.text = txtPhoneNumber.text?.replacingOccurrences(of: "+55", with: "+1")
        }
       else{
        language = "BR"
            maskedDelegate = MaskedTextFieldDelegate(format: "+55 ([00]) [00000]-[00009]")
            maskedDelegate.listener = self
            
            txtPhoneNumber.delegate = maskedDelegate
             txtPhoneNumber.text = txtPhoneNumber.text?.replacingOccurrences(of: "+1", with: "+55")
        }
    }
    
    
    override func viewDidLoad() {
        let user = GlobalData.IsLogged()
        if (user.ID > 0)
        {
            LoaderController().showActivityIndicator(uiView: self.view)
            self.perform(#selector(ViewController.showNavController), with: nil, afterDelay: 0)
            self.view.isHidden = true;
            txtPassword.isHidden = true;
            txtPhoneNumber.isHidden = true;
        }
        else{
            txtPassword.isHidden = false;
            txtPhoneNumber.isHidden = false;
            self.view.isHidden = false;
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.addDoneButtonOnKeyboard()
        self.addBtnLogIn()
        self.addBtnCreate()
        self.addBtnForgot()
        
        maskedDelegate = MaskedTextFieldDelegate(format: "+1 ([099]) [00000]-[00009]")
        maskedDelegate.listener = self
        
        txtPhoneNumber.delegate = maskedDelegate
        }
            
    }
    
    
    func addBtnCreate()
    {
        
        // let button = UIButton(frame: CGRect(x: 10, y: 60, width: self.view.bounds.width - 20, height: 50))
        let button = UIButton(frame: CGRect(x:10,y: self.view.bounds.height - 70, width: self.view.bounds.width - 20, height: 50))
        
        button.backgroundColor =  UIColor.black
        button.setTitle("Create Account", for: .normal)
        
        button.addTarget(self, action: #selector(pressButtonCreate(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    func addBtnLogIn()
    {
        
       // let button = UIButton(frame: CGRect(x: 10, y: 60, width: self.view.bounds.width - 20, height: 50))
        let button = UIButton(frame: CGRect(x:10,y: self.view.bounds.height - 190, width: self.view.bounds.width - 20, height: 50))
        
        button.backgroundColor =  UIColor.black
        button.setTitle("Log In", for: .normal)
        
        button.addTarget(self, action: #selector(pressButtonLogIn(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    func addBtnForgot()
    {
        
       // let button = UIButton(frame: CGRect(x: 10, y: 10, width: self.view.bounds.width - 20, height: 50))
        let button = UIButton(frame: CGRect(x:10,y: self.view.bounds.height - 130, width: self.view.bounds.width - 20, height: 50))
        button.backgroundColor =  UIColor.black
        button.setTitle("Forgot Password?", for: .normal)
        
        button.addTarget(self, action: #selector(pressButtonForgot(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        
        
    }

    
    func pressButtonLogIn(button: UIButton) {
        
        let msg = validarLogin()
        if(msg != "")
        {
            // the alert view
            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            
            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
            }
        }else{
             //self.perform(#selector(ViewController.showNavController), with: nil, afterDelay: 2)
            
            var phone =  txtPhoneNumber.text!
          
            phone = phone.replacingOccurrences(of: "+", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: "(", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: ")", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: "-", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: " ", with: "",options: NSString.CompareOptions.literal, range: nil)
            
            LoaderController().showActivityIndicator(uiView: self.view)
            
            UserService.GetLogin(uiview: self.view, phone: phone, senha: txtPassword.text!, completion:{(success, entidade, json) -> Void in
                if(success){
                    
                    
                    OperationQueue.main.addOperation {
                        if entidade.ID > 0
                        {
                            let prefs:UserDefaults = UserDefaults.standard
                            prefs.set(json, forKey: BaseService.JsonLogin)
                            
                            /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             
                             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RevealView") as! SWRevealViewController
                             self.present(nextViewController, animated:true, completion:nil)
                             */
                            self.perform(#selector(ViewController.showNavController), with: nil, afterDelay: 2)
                            
                        }
                        else{
                            
                            
                            // create the alert
                            let alert = UIAlertController(title: "Notice", message: "Incorrect authentication.", preferredStyle: UIAlertControllerStyle.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                else
                {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Notice", message: "Incorrect authentication.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                
                LoaderController().hideActivityIndicator(uiView: self.view)
                
            })
            
            
            
            //self.perform(#selector(ViewController.showNavController), with: nil, afterDelay: 2)
            
        }

    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0,y: 0, width:320,height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.txtPhoneNumber.inputAccessoryView = doneToolbar
        self.txtPassword.inputAccessoryView = doneToolbar
        
    }
    
    func showNavController(){
        performSegue(withIdentifier: "startViews", sender: self)
    }
    
    func pressButtonCreate(button: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let simpleVC = storyBoard.instantiateViewController(withIdentifier: "ModalCreateAccountController") as! ModalCreateAccountController
        
        simpleVC.delegate = self
        let config = JModalConfig(transitionDirection: .bottom, animationDuration: 0.2, backgroundTransform: true, tapOverlayDismiss: true)
        presentModal(self, modalViewController: simpleVC, config: config) {
            //print("Presented Simple Modal")
        }
    }
    
    func pressButtonForgot(button: UIButton) {
        
        let msg = validarForget()
        if(msg != "")
        {
            // the alert view
            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            
            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
            }
        }else{
            var phone =  txtPhoneNumber.text!
            
            phone = phone.replacingOccurrences(of: "+", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: "(", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: ")", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: "-", with: "",options: NSString.CompareOptions.literal, range: nil)
            phone = phone.replacingOccurrences(of: " ", with: "",options: NSString.CompareOptions.literal, range: nil)
            
            
            UserService.ForgotPassword(uiview: UIView(), phone: phone, completion:{(success, entidade, json) -> Void in
                if(success){
                    
                    OperationQueue.main.addOperation {
                        if entidade.ID > 0
                        {
                            
                            // create the alert
                            let alert = UIAlertController(title: "Notice", message: "Please, check your e-mail!", preferredStyle: UIAlertControllerStyle.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)                        }
                        else{
                            
                            
                            // create the alert
                            let alert = UIAlertController(title: "Notice", message: "Phone number not found!", preferredStyle: UIAlertControllerStyle.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                else
                {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Notice", message: "Incorrect authentication.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            })
            

        }
    
    }
    
    
    func validarLogin() -> String{
        
        var msgErro: String = ""
        
        if txtPhoneNumber.text == "" {
            setErrorTxt(txt: self.txtPhoneNumber)
            msgErro = "Phone Number required"
        } else if txtPassword.text == "" {
            setErrorTxt(txt: txtPassword)
            msgErro = "Password required"
        }
        /*
         
        
        if(){
         
        }
        else
        {
        }
        if !(txtEmail.text?.isValidEmail())! {
            setErrorTxt(txt: txtEmail)
            if msgErro == "" {
                msgErro = "E-mail incorreto"
            }
            else
            {
                msgErro = "Campo(s) obrigatórios"
            }
        }*/
        
        return msgErro
    }
    
    
    func validarForget() -> String{
        
        var msgErro: String = ""
        
        if txtPhoneNumber.text == "" {
            setErrorTxt(txt: self.txtPhoneNumber)
            msgErro = "Phone Number required"
        }
        
        /*
         if !(txtEmail.text?.isValidEmail())! {
         setErrorTxt(txt: txtEmail)
         if msgErro == "" {
         msgErro = "E-mail incorreto"
         }
         else
         {
         msgErro = "Campo(s) obrigatórios"
         }
         }*/
        
        return msgErro
    }
    
    
    func setErrorTxt(txt: UITextField){
        
        txt.layer.masksToBounds = true
        txt.layer.borderColor = UIColor.red.cgColor
        txt.layer.borderWidth = CGFloat(1)
        
    }

    
    /*
     
     // the alert view
     let alert = UIAlertController(title: "", message: "Código copiado com sucesso", preferredStyle: .alert)
     self.present(alert, animated: true, completion: nil)
     
     // change to desired number of seconds (in this case 5 seconds)
     let when = DispatchTime.now() + 2
     DispatchQueue.main.asyncAfter(deadline: when){
     // your code with delay
     alert.dismiss(animated: true, completion: nil)
     }
     
     
     
     
     
     
     func addbuttonLogin()
    {
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: self.view.bounds.width - 20, height: 50))
        //let button = UIButton(frame: CGRect(x: 25, y: self.view.bounds.height - 70, width: self.view.bounds.width - 50, height: 50))
        button.backgroundColor =  UIColor.black // UIColor.uicolorFromHex(0x4794FE, alpha: 1)
        button.setTitle("Log in", for: .normal)
        
        button.addTarget(self, action: #selector(pressButtonLogin(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        
        
        let viewBottom = UIView(frame: CGRect(x:0,y: self.view.bounds.height - 70, width: self.view.bounds.width, height: 100))
        viewBottom.layer.backgroundColor =  UIColor.clear.cgColor //UIColor.white.cgColor
        viewBottom.addSubview(button)
        
        self.view.addSubview(viewBottom)
        
        
    }
    func pressButtonLogin(button: UIButton) {
    }*/
    func doneButtonAction()
    {
        self.txtPhoneNumber.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

