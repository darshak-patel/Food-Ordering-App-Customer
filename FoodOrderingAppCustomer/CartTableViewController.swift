//
//  CartTableViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 15/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase
import DropDown

class CartTableViewController: UITableViewController,DropDownbuttonfunctiondelegate {
    
    
    
    func DeleteItem(at index: IndexPath, cell: CartTableViewCell) {
        let userid = Auth.auth().currentUser?.uid
        let itemkey = cell.ItemKeyLbl.text
        let deletedbref = Database.database().reference().child("users").child(userid!).child("cart").child(itemkey!)
        
        
        print(itemkey!)
        
        deletedbref.removeValue()
        
        let indexp = index.row
        
        self.cartitemfarr.remove(at: indexp)
        
        
        
        
        
        DispatchQueue.main.async {
            
            
            print(self.cartitemfarr)
            
            self.tableView.reloadData()
        
        }
    
    
    
    }
    
    
    
    //DropDownBtnAction
    
    let dropDown = DropDown()

    
    // Fetching Cart Items
    
    
    var cartitemfarr = [CartModel]()
    
    func fetchcartitems(){
        
        
            let userid = Auth.auth().currentUser?.uid
        
        
        Database.database().reference().child("users").child(userid!).child("cart").observe(.childAdded, with: { (snapshot) in
            
            print("THIS IS CART SNAPSHOT \(snapshot)")
            
            
            if let cartdict = snapshot.value as? [String:AnyObject]{
                
                let cartitems = CartModel()
                
               cartitems.categorykey = cartdict["categorykey"] as? String
                cartitems.itemkey = cartdict["itemkey"] as? String
                cartitems.itemname = cartdict["itemname"] as?
                String
                cartitems.itemprice = cartdict["itemprice"] as? String
                cartitems.storeuid = cartdict["storeuid"] as? String
                cartitems.quantity = cartdict["quantity"] as? String
                cartitems.itemnetprice = cartdict["itemnetprice"] as? String
                
                self.cartitemfarr.append(cartitems)
                
               
                
                
                
                
            }
            
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        
        
        
        }
        
        )
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchcartitems()
        
        

        navigationItem.title = "Your Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
//        print("THIS IS PRICEARRAY \(self.pricearray)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cartitemfarr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTab", for: indexPath) as? CartTableViewCell
        
        
        let cartitems = cartitemfarr[indexPath.row]
        
       
        
        cell?.CartItemName.text = cartitems.itemname
        cell?.CartItemPrice.text = cartitems.itemprice
        cell?.QuantityLbl.text = cartitems.quantity
        cell?.ItemKeyLbl.text = cartitems.itemkey
        cell?.NetPrice.text = String( Int(cartitems.itemprice!)! * Int(cartitems.quantity!)! )
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        
        // Configure the cell...

        return cell!
    }

    @IBOutlet weak var NETlbl: UILabel!
    
    
//    func sum(_ data: [Int]) -> Int{
//        var result : Int = 0
//        var idx : Int = 0
//
//        for element in data{
//
//            result += data[idx]
//
//            idx += 1
//
//            print(element)
//
//        }
//        return result
//    }
//
//    let array:[Int] = [2,2,2,2,2,2]
//
//    var pricearray:[Int] = []
    
   
    
    
   
    
    
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    

    









}


//END//
//___
