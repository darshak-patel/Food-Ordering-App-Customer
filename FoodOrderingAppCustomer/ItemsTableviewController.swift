//
//  ItemsTableviewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 11/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import Firebase

class ItemsTableviewController: UITableViewController,cellbuttonfunctiondelegate {
   
    
    //CellDelegateMethod
    
    var StoreUID : String?
    
    func Uploadtocart(at index: IndexPath, cell: ItemsTableviewTableViewCell) {
        print(cell.ItemOrderBtn.tag)
        
        let alertviewcont = UIAlertController.init(title: "Item Added To Cart", message: "", preferredStyle: .actionSheet)
        present(alertviewcont, animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
        let uid = Auth.auth().currentUser?.uid
        
        print(uid!)
        
        
        let itemid = cell.ItemKeylbl.text
        print(itemid!)
        
        let reffinal = Database.database().reference().child("users").child(uid!).child("cart").child(itemid!)
        
        
        print("This Is Index \(index)")
        
        let itemname = cell.ItemNameLbl.text
        print(itemname!)
        reffinal.child("itemname").setValue(itemname!)
        
        let itemkey = cell.ItemKeylbl.text
        print(itemkey!)
        reffinal.child("itemkey").setValue(itemkey!)
        
        let categorykey = cell.ItemCategoryKeyLbl.text
        print(categorykey!)
        reffinal.child("categorykey").setValue(categorykey!)
        
        let itemprice = cell.ItemPriceLbl.text
        print(itemprice!)
        reffinal.child("itemprice").setValue(itemprice!)
        
        print(StoreUID!)
        reffinal.child("storeuid").setValue(StoreUID!)
        
        reffinal.child("quantity").setValue("1")
        
        
        
        
//        let storeuidsend = self.storeuid!
//        print(storeuidsend)
//        reffinal.child("storeuid").setValue(storeuidsend)
    }
    
    //Arrays
    
    var itemarr = [itemssellermodel]()
    var finalarr = [finallistarrmodel]()
    
    var cat001 = [itemssellermodel]()
    var cat002 = [itemssellermodel]()
    var cat003 = [itemssellermodel]()
    var cat004 = [itemssellermodel]()
    var cat005 = [itemssellermodel]()
    
    
    func fetchStoreUID(){
        let dbrefmisc = Database.database().reference().child("misc")
        
        dbrefmisc.observe(.childAdded) { (snap) in
            print(snap)
            if let dictionaryuid = snap.value as? String{
                
                print("THis Is Dictionary \(dictionaryuid)")
                
                self.StoreUID = dictionaryuid
                  
            }
        }
    }
    
    
    func fetchItemsCategory(){
        
            print(StoreUID!)
        Database.database().reference().child("storedata").child(StoreUID!).child("items").observe(.childAdded, with: { (snapshot) in
            
            print("This Is Snap: \(snapshot)")
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                let items = itemssellermodel()
                
                items.itemprice = dictionary["itemprice"] as? String
                items.categorykey = dictionary["categorykey"] as? String
                items.itemkey = dictionary["itemkey"] as? String
                items.itemname = dictionary["itemname"] as? String
                
                
                
                print("THIS IS ITEM PRICE \(String(describing: items.itemprice!))")
                
                if items.categorykey == "0001" {
                    self.cat001.append(items)
                }
                if items.categorykey == "0002" {
                    self.cat002.append(items)
                }
                if items.categorykey == "0003" {
                    self.cat003.append(items)
                }
                if items.categorykey == "0004" {
                    self.cat004.append(items)
                }
                if items.categorykey == "0005" {
                    self.cat005.append(items)
                }
                    
                else{
                    self.itemarr.append(items)
                }
                
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                
            }//dispatchqueue
            
            
            //            }//letdictionary
            
        }, withCancel: nil)//Database
    }//fetchitemscategory()
    

    override func viewDidAppear(_ animated: Bool) {
        
         fetchItemsCategory()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStoreUID()
        
       
        
        navigationItem.title = "Add To Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func BackBtnAct(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        
        if section == 0 {
            label.text = "Main Course"
            label.backgroundColor  = UIColor.red
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 20)
            
        }
        if section == 1 {
            label.text = "Snacks"
            label.backgroundColor  = UIColor.red
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 20)
        }
        if section == 2 {
            label.text = "Ice-Creams"
            label.backgroundColor  = UIColor.red
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 20)
        }
        if section == 3 {
            label.text = "Sandwiches"
            label.backgroundColor  = UIColor.red
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 20)
        }
        if section == 4 {
            label.text = "Refreshments"
            label.backgroundColor  = UIColor.red
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        
        
        return label
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return cat001.count
        }
        if section == 1{
            return cat002.count
        }
        if section == 2 {
            return cat003.count
        }
        if section == 3 {
            return cat004.count
        }
        if section == 4 {
            return cat005.count
        }
        
        
        return 0
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderSCell") as! ItemsTableviewTableViewCell
        
        
        
        
        if indexPath.section == 0 {
            
            
            let item = cat001[indexPath.row]
            
            cell.ItemNameLbl.text = item.itemname
            cell.ItemPriceLbl.text = item.itemprice!
            cell.ItemCategoryKeyLbl.text
                = item.categorykey
            cell.ItemKeylbl.text = item.itemkey
            
            
            
            
        }
        if indexPath.section == 1{
            
            let item = cat002[indexPath.row]
            
            cell.ItemNameLbl.text = item.itemname
            cell.ItemPriceLbl.text = item.itemprice!
            cell.ItemCategoryKeyLbl.text
                = item.categorykey
            cell.ItemKeylbl.text = item.itemkey
//            cell.itemtag.text = "\(String(describing: item.tag!))"
//
        }
        if indexPath.section == 2 {
            
            
            let item = cat003[indexPath.row]
            
            cell.ItemNameLbl.text = item.itemname
            cell.ItemPriceLbl.text = item.itemprice!
            cell.ItemCategoryKeyLbl.text
                = item.categorykey
            cell.ItemKeylbl.text = item.itemkey
//            cell.itemtag.text = "\(String(describing: item.tag!))"
//            cell.ItemPriceLbl.tag = item.tag!
//            cell.ItemOrderBtn.tag = item.tag!
        }
        if indexPath.section == 3{
            
            let item = cat004[indexPath.row]
            
            cell.ItemNameLbl.text = item.itemname
            cell.ItemPriceLbl.text = item.itemprice!
            cell.ItemCategoryKeyLbl.text
                = item.categorykey
            cell.ItemKeylbl.text = item.itemkey
//            cell.itemtag.text = "\(String(describing: item.tag!))"
//
        }
        if indexPath.section == 4 {
            
            
            let item = cat005[indexPath.row]
            
            cell.ItemNameLbl.text = item.itemname
            cell.ItemPriceLbl.text = item.itemprice!
            cell.ItemCategoryKeyLbl.text
                = item.categorykey
            cell.ItemKeylbl.text = item.itemkey
//            cell.itemtag.text = "\(String(describing: item.tag!))"
            
            
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    

    
}
