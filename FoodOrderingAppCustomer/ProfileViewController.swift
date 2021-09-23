//
//  ProfileViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 22/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileimageview: UIImageView!
    
    @IBOutlet weak var usernamelabel: UILabel!
    
    func fetchprofiledetails(){
        
        let userid = Auth.auth().currentUser?.uid
        
        
        Database.database().reference().child("users").child("\(userid ?? "UID")").observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                
                print("profile dictionary \(dictionary)")
                
                //user.setValuesForKeys(dictionary)
                
                self.usernamelabel.text = dictionary["name"] as? String
                
                
                
                self.profileimageview.image = UIImage(named: "default-profileWhite'")
                
                if let profileimageurl = dictionary["profileimageurl"]{
                    
                    
                    self.profileimageview.loadimagecache(urlstring: profileimageurl as! String)
                }
            }
        }, withCancel: nil)
        
    }
    
    
    @IBAction func LogoutAct(_ sender: UIButton) {
        
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! ViewController
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchprofiledetails()
        
        self.profileimageview.layer.cornerRadius = profileimageview.frame.width/2
        self.profileimageview.clipsToBounds = true

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
