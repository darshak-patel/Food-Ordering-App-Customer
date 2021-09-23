//
//  AddresbookViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 22/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase

class AddresbookViewController: UIViewController {

    @IBOutlet weak var AddressTxtView: UITextView!
    
    @IBOutlet weak var SubmitBtn: UIButton!
    
    func uploadaddress() {
        
        let uid = Auth.auth().currentUser?.uid
        
        
        let dbref = Database.database().reference().child("users").child(uid!)
        
        
        let addresstxt = self.AddressTxtView.text
        
        dbref.child("address").setValue(addresstxt)
        
        
    }
    
    @IBAction func SubmitBtnact(_ sender: UIButton) {
        
        uploadaddress()
        
        let alertvc = UIAlertController.init(title: "Added Successfully", message: "Your address is updated.", preferredStyle: .alert)
        
        let okact = UIAlertAction.init(title: "OK", style: .default) { (dismiss) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertvc.addAction(okact)
        
        present(alertvc, animated: true, completion: nil)
        
    }
    
    @IBAction func BackBtnAct(_ sender: UIButton) {
        
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mycolorblack = UIColor.black
        
        
        self.AddressTxtView.layer.borderColor = mycolorblack.cgColor
        self.AddressTxtView.layer.borderWidth = 2
        
        
        self.SubmitBtn.layer.cornerRadius = 15.0
        self.SubmitBtn.clipsToBounds = true
        
        
        
        
        
        navigationItem.title = "Address Book"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        navigationController?.navigationBar.tintColor = UIColor.white

        // Do any additional setup after loading the view.
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
