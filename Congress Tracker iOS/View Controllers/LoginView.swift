//
//  ViewController.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/24/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailInputField: UITextField!
    
    @IBOutlet weak var passwordInputField: UITextField!
    
    @IBOutlet weak var loginErrorLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        self.emailInputField.delegate = self
        self.passwordInputField.delegate = self
        let email = emailInputField.text
        let password = passwordInputField.text
        if(email!.isEmpty || password!.isEmpty){
            loginErrorLbl.isHidden = false
            
        }else{
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if(error != nil){
                    self.loginErrorLbl.isHidden = false
                }else{
                    self.transitionToMainScreen()
                }
            }
        }
    }
    func transitionToMainScreen(){
          performSegue(withIdentifier: "loginValidSegue", sender: nil)
           
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let  destinationVC = segue.destination as? CongressView{
                   destinationVC.loggedIn = true
               }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    
}

