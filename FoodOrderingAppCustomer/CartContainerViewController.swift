//
//  CartContainerViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 21/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase

class CartContainerViewController: UIViewController {
    
    @IBAction func BackBtnCC(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func ProceedCC(_ sender: UIButton) {
        
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //checkkart()
    }
   
    @IBOutlet weak var EmptyCartIV: UIImageView!
    
    @IBOutlet weak var ProceedToPaybtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.title = "Your Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkkart(){
        
        let userid = Auth.auth().currentUser?.uid
        
        let dbref = Database.database().reference().child("users").child(userid!).child("cart")
        
        dbref.observe(.value) { (snap) in
            
            print("snap\(snap)")
            
            if snap.value == nil
            {
                self.ProceedToPaybtn.alpha = 0
                self.EmptyCartIV.alpha = 1
            }
            else{
                
                self.ProceedToPaybtn.alpha = 1
                self.EmptyCartIV.alpha = 0
            }
        }
        
    }
    

    

}
