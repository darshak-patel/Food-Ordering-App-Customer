//
//  DSGViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 05/05/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase

class DSGViewController: UIViewController {
    
    
     var uidkey:String?
    
    //Sending Store Uid
    
    @IBAction func OrderBtnAction(_ sender: UIButton) {
    
        let dbrefmisc = Database.database().reference().child("misc").child("storeuid")
        
        dbrefmisc.setValue(uidkey!)
        
        
    }
    
    
   
    
   
    
    
  //OUTLETS
    
    
    @IBOutlet weak var StoreImage: UIImageView!
    
    @IBOutlet weak var StoreNameLBL: UILabel!
    
    @IBOutlet weak var StoreAreaLbl: UILabel!
    
    @IBOutlet weak var StoreCategoriesLBL: UILabel!
    
    @IBOutlet weak var StoreAddressLBL: UILabel!
    
    @IBOutlet weak var StoreUIDlbl: UILabel!
    
    func HandleData() {
        let dbref = Database.database().reference()
        
        let key = uidkey
        
        dbref.child("storedata").child("\(key ?? "HIeDT8VmfzcKPwVDbV58xiobYXx1")").observe(.value) { (snap) in
            if let dictionary = snap.value as? [String:AnyObject]{
                
                let imageurl = dictionary["profileimageurl"] as? String
                
                print(dictionary)
                self.StoreNameLBL.text = dictionary["storename"] as? String
                self.StoreAreaLbl.text = dictionary["storearea"] as? String
                self.StoreCategoriesLBL.text = dictionary["storecategories"] as? String
                self.StoreAddressLBL.text = dictionary["storeaddress"] as? String
                
                self.StoreImage.image = UIImage(named: "foodphoto3")
                
                self.StoreImage.loadimagecache(urlstring: imageurl!)
            }
        }
        
    }
    
    
    
    @IBAction func dismissbackDSHG(_ sender: UIButton) {
dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        print(uidkey ?? "HIeDT8VmfzcKPwVDbV58xiobYXx1")
        
        self.StoreUIDlbl.text = "\(uidkey ?? "HIeDT8VmfzcKPwVDbV58xiobYXx1")"
        
        print("THIS IS STORE UID \(self.StoreUIDlbl.text!)")
        
        super.viewDidLoad()

        HandleData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    

}
