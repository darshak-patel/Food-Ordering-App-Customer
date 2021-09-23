//
//  ViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 02/05/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var LoginBTN: UIButton!
    
    @IBOutlet weak var emailTXTfield: UITextField!
    
    @IBOutlet weak var passwordTXTfield: UITextField!
    
//SIGNIN
    
    func handleSignIn(){
        guard let emailLI = emailTXTfield.text else {
            print("Please Enter Correct Email")
            return
        }
        guard  let passwordLI = passwordTXTfield.text else {
            print("Please Enter Correct Password")
            return
        }
        
        Auth.auth().signIn(withEmail: emailLI, password: passwordLI) { (user, errorLI) in
            
            if errorLI != nil {
                
                
                let alertactioncontroller4 = UIAlertController(title: "Invalid Login", message: "Please Review Your Login Details", preferredStyle: .alert)
                
                let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertactioncontroller4.addAction(okaction)
                
                self.present(alertactioncontroller4, animated: true, completion: nil)
                
                print(errorLI ?? "No Error")
                return
            }
                
                
            else{
                
                let presentview = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenTab")
                
                self.present(presentview!, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func LoginBTN(_ sender: UIButton) {
        handleSignIn()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    /*//emitter
    
    func emitterui(){
        let emitter = Emitter.get(with: #imageLiteral(resourceName: "DonutEmitterCellWhite"))
        
        //position of emitter
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y: 0)
        
        //size of emitter
        
        emitter.emitterSize = CGSize(width: view.frame.width, height:  2 )
        
        //add emitter to view
        
        view.layer.addSublayer(emitter)
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //emitter
        
        //emitterui()
        
        emailTXTfield.layer.cornerRadius = 15.0
        
        
        passwordTXTfield.layer.cornerRadius = 15.0
        emailTXTfield.clipsToBounds = true
        
        passwordTXTfield.clipsToBounds = true
        
        LoginBTN.layer.cornerRadius = 15.0
        
        
        
        LoginBTN.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

