//
//  PaymentsViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 21/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase

class PaymentsViewController: UIViewController {

    @IBOutlet weak var ViewLining: UIView!
    
    @IBOutlet weak var NetPriceLbl: UILabel!
    
    @IBOutlet weak var NetBeforeTaxLbl: UILabel!
    
    @IBOutlet weak var GrandTotalLbl: UILabel!
    
 
    
    
    
//CARTARR
    
    
    var cartitemfarr = [CartModel]()
    
    func fetchcartitems(){
        
        
        let userid = Auth.auth().currentUser?.uid
        
        
        Database.database().reference().child("users").child(userid!).child("cart").observe(.childAdded, with: { (snapshot) in
            
            print("THIS IS CART SNAPSHOT \(snapshot)")
            
            
            if let cartdict = snapshot.value as? [String:AnyObject]{
                
                
//                let dbreftest = Database.database().reference().child("users").child(userid!).child("test")
//                let itemkey = cartdict["itemkey"]
//
//                dbreftest.child(itemkey as! String).setValue(cartdict)
                
                let cartitems = CartModel()
                
                cartitems.itemnetprice = cartdict["itemprice"] as? String
                
                self.cartitemfarr.append(cartitems)
                
                //print("THIS IS CARTNET \(cartitems.itemnetprice!)")
                
                self.totalPriceInCart()
                
                
            }
            
        }
            
        )
        
    }
    
    
    
    var netpricevar:Int?
    
    
//SUMMING FUNCTION
    
    func totalPriceInCart() -> Int {
        var totalPrice: Int = 0
        
        for product in cartitemfarr {
            
            totalPrice += Int(product.itemnetprice!)!
            
        }
        
        print("THIS IS TOTAL PRICE \(totalPrice)")
        
        //        self.NETlbl.text = String(totalPrice)
        
        self.NetPriceLbl.text = String(totalPrice)
        self.NetBeforeTaxLbl.text = String(totalPrice)
        
        let GrandTot = totalPrice + 61
        
        self.GrandTotalLbl.text = String(GrandTot)
        
        netpricevar = GrandTot
        
        return totalPrice
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totalPriceInCart()
        addressretreival()
        
        self.AddAddressBtn.alpha = 0
        
        
    }
    
    @IBOutlet weak var addtxtview: UITextView!
    @IBOutlet weak var AddAddressBtn: UIButton!
    @IBOutlet weak var ShippingaddLbl: UILabel!
    
    func addressretreival() {
        
        let uid = Auth.auth().currentUser?.uid
        
        let adddbref = Database.database().reference().child("users").child(uid!)
        
        adddbref.observe(.value) { (addsnap) in
            
            
            
            if let dict = addsnap.value as? [String:AnyObject]{
                
                if dict["address"] != nil{
                
                self.ShippingaddLbl.alpha = 1
                self.addtxtview.alpha = 1
                
                self.addtxtview.text = dict["address"] as? String
                
                
                }
                
                else{
                    
                    self.AddAddressBtn.alpha = 1
                    
                }
            
            
            
            
            }
            
            
                
            
                
                
           
            
            
        }
        
    }
    
    
    @IBOutlet weak var PODimage: UIImageView!
    
    @IBAction func tapPod(_ sender: UITapGestureRecognizer) {
        
        self.PODimage.image = UIImage(named: "ButtonEnabled")
        
        
    }
    
    @IBAction func Placeorderbtn(_ sender: UIButton) {
        
        
        let userid = Auth.auth().currentUser?.uid
        
        
        Database.database().reference().child("users").child(userid!).child("cart").observe(.childAdded, with: { (snapshot) in
            
            print("THIS IS CART SNAPSHOT \(snapshot)")
            
            
            if let cartdict = snapshot.value as? [String:AnyObject]{
                
                
                let dbreforders = Database.database().reference().child("users").child(userid!).child("orders")
                
                let dbrefordershist = Database.database().reference().child("users").child(userid!).child("orders-history")
                
                
                let itemkey = cartdict["itemkey"]
                let selleruid = cartdict["storeuid"]
                
                
                let dbrefordershistseller = Database.database().reference().child("storedata").child(selleruid as! String).child("orders-history").child(userid!)
                let dbrefordersseller = Database.database().reference().child("storedata").child(selleruid as! String).child("orders").child(userid!)
                
                dbreforders.child(itemkey as! String).setValue(cartdict)
                dbrefordershist.child(itemkey as! String).setValue(cartdict)
                dbrefordersseller.child(itemkey as! String).setValue(cartdict)
                dbrefordershistseller.child(itemkey as! String).setValue(cartdict)
                
                
                
                let userinfo = Database.database().reference().child("users").child(userid!)
                
                userinfo.observe(.value) { (snap) in
                    
                    if let dict = snap.value as? [String:AnyObject]{
                        
                        
                        let name = dict["name"] as? String
                        let phone = dict["phonenumber"] as? String
                        let address = dict["address"] as? String
                        
                        let dbrefsellerinfo = Database.database().reference().child("storedata").child(selleruid as! String).child("orders").child(userid!)
                        
                        let dbrefsellerinfohist = Database.database().reference().child("storedata").child(selleruid as! String).child("orders-history").child(userid!)
                        
                        dbrefsellerinfo.child("username").setValue(name!)
                        
                            dbrefsellerinfo.child("userid").setValue(userid!)
                        
                        
                            dbrefsellerinfohist.child("userid").setValue(userid!)
                        
                        dbrefsellerinfohist.child("username").setValue(name!)
                        dbrefsellerinfo.child("userphone").setValue(phone!)
                        
                        dbrefsellerinfohist.child("userphone").setValue(phone!)
                        
                        dbrefsellerinfo.child("address").setValue(address!)
                        
                        dbrefsellerinfohist.child("address").setValue(address!)
                        
                        dbrefsellerinfo.child("itemnetprice").setValue(self.netpricevar)
                        
                        dbrefsellerinfohist.child("itemnetprice").setValue(self.netpricevar)
                        
                        
                        
                        
                    }
                    
                    
                }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            }
        })
        
        
        
        
        
        let actview = UIAlertController.init(title: "Success", message: "Order Placed Successfully", preferredStyle: .alert)
        
        let okact = UIAlertAction.init(title: "OK", style: .default) { (handler) in
            
            let userid = Auth.auth().currentUser?.uid
            
            let dbref = Database.database().reference().child("users").child(userid!).child("cart")
            
            dbref.removeValue()
            
            self.dismiss(animated: true, completion: nil)
            
            
        }
        
        actview.addAction(okact)
        present(actview, animated: true, completion: nil)
        
       
    
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchcartitems()
        
        self.ShippingaddLbl.alpha = 0
        self.addtxtview.alpha = 0
        self.AddAddressBtn.alpha = 0
        
        
        
        addressretreival()
        navigationItem.title = "Payments"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red
        
            
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
            let mycolor = UIColor.black
        self.ViewLining.layer.borderColor = mycolor.cgColor
        
        self.ViewLining.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
