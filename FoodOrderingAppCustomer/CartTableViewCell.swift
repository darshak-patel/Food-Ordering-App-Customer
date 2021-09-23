//
//  CartTableViewCell.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 15/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//
import UIKit
import DropDown
import Firebase


protocol DropDownbuttonfunctiondelegate {
    
    func DeleteItem(at index:IndexPath, cell:CartTableViewCell)
    
}





class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var CartItemName: UILabel!
    
    
    @IBOutlet weak var CartItemPrice: UILabel!
    @IBOutlet weak var QuantityLbl: UILabel!
    
    @IBOutlet weak var DropDownBtn: UIButton!
    @IBOutlet weak var TempQuanLbl: UILabel!
    @IBOutlet weak var ItemKeyLbl: UILabel!
    @IBOutlet weak var DeleteBtn: UIButton!
    @IBOutlet weak var NetPrice: UILabel!
    
   
    let DropDownVar = DropDown()
    var delegate:DropDownbuttonfunctiondelegate?
    var indexPath:IndexPath!
    
    @IBAction func DropDownAction(_ sender: UIButton) {
        
        DropDownVar.anchorView = sender
        
        DropDownVar.dataSource = ["1", "2", "3","4"]
        
        DropDownVar.direction = .bottom
        DropDownVar.bottomOffset = CGPoint(x: 0, y: (DropDownVar.anchorView?.plainView.bounds.height)!)
        
        DropDownVar.show()
        
        
        
       DropDownVar.selectionAction = { (index: Int, item: String) in
            
            print("Selected item: \(item) at index: \(index)")
        
            self.TempQuanLbl.text = item
        
            print("\(self.TempQuanLbl.text!)")
        
            self.QuantityLbl.text = item
        
            let userid = Auth.auth().currentUser?.uid
            let itemkey = self.ItemKeyLbl.text
        
            let dropdbref = Database.database().reference().child("users").child(userid!).child("cart").child(itemkey!).child("quantity")
        
            
        if item == "1"{
            
            dropdbref.setValue("1")
            
        }
        
        if item == "2"{
            
            dropdbref.setValue("2")
        }
        
        if item == "3"{
            
            dropdbref.setValue("3")
        }
        
        if item == "4"{
            
            dropdbref.setValue("4")
            
            
            }
        
        
        let dropdbrefprice = Database.database().reference().child("users").child(userid!).child("cart").child(itemkey!).child("itemprice")
        let dropdbrefquantity = Database.database().reference().child("users").child(userid!).child("cart").child(itemkey!).child("quantity")
        var pricevar : String?
        var quantityvar : String?
        
        
        
        dropdbrefprice.observe(.value, with: { (pricesnap) in
            
            print("THIS IS PRICESNAP \(pricesnap)")
            pricevar = pricesnap.value as? String
            print("THIS IS PRICEVAR \(String(describing: pricevar))")
            
        })
        
        
        
        
        dropdbrefquantity.observe(.value, with: { (quantitysnap) in
            
            print("THIS IS QUANSNAP \(quantitysnap)")
            quantityvar = quantitysnap.value as? String
            print("THIS IS QUANvar \(String(describing: quantityvar))")
            
            if pricevar != nil{
            let netpricevar = Int(pricevar!)! * Int(quantityvar!)!
            print("THIS IS NET \(netpricevar)")
            
            self.NetPrice.text = String(netpricevar)
            
            let dropdbrefitemnetprice = Database.database().reference().child("users").child(userid!).child("cart").child(itemkey!).child("itemnetprice")
            
                dropdbrefitemnetprice.setValue(netpricevar)
                
            }
            else{
                
            }
            
            
        })
        
        
            
        }
        
        
    
    }
    
    
    
   
   
    @IBAction func DeleteBtnAction(_ sender: UIButton) {
        
        delegate?.DeleteItem(at: indexPath, cell: self)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
