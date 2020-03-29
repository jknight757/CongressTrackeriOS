//
//  SignUpView.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/27/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailIF: UITextField!
    
    
    @IBOutlet weak var nameInputField: UITextField!
    
    @IBOutlet weak var passwordInputField: UITextField!
    
    @IBOutlet weak var confirmPassIF: UITextField!
    @IBOutlet weak var signUpErrorLbl: UIButton!
    @IBOutlet weak var passwordShortError: UIButton!
    
    @IBOutlet weak var passMatchError: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailIF.delegate = self
        nameInputField.delegate = self
        passwordInputField.delegate = self
        confirmPassIF.delegate  = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        var email = emailIF.text
        var name = nameInputField.text
        var password = passwordInputField.text
        var password2 = confirmPassIF.text
        
        if(email!.isEmpty || name!.isEmpty || password!.isEmpty || password!.isEmpty){
            signUpErrorLbl.isHidden = false
            passwordShortError.isHidden = true
            passMatchError.isHidden = true
        }else{
            if(password!.count < 6){
                passwordShortError.isHidden = false
                passMatchError.isHidden = true
            }else if (password != password2){
                passMatchError.isHidden = false
            }else{
                
                Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                    if  err != nil{
                        self.signUpErrorLbl.isHidden = false
                        print(err!.localizedDescription)
                    }else{
                        
                        let db = Firestore.firestore()
                        var ref: DocumentReference? = nil
                        ref = db.collection("users").addDocument(data: ["name" : name,
                            "Uid": result!.user.uid]){ (error) in
                            if error != nil{
                            }
                        }
                        
                        self.transitionToMainScreen()
                        
                    }
                }
            }
        }
        
    }
    func transitionToMainScreen(){
        performSegue(withIdentifier: "signUpSegue", sender: nil)
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
