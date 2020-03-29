//
//  ViewController.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/24/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailInputField: UITextField!
    
    @IBOutlet weak var passwordInputField: UITextField!
    
    @IBOutlet weak var loginErrorLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.emailInputField.delegate = self
       // self.passwordInputField.delegate = self
        
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        let email = emailInputField.text
        let password = passwordInputField.text
        if(email!.isEmpty || password!.isEmpty){
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    
}

