//
//  ItemsTableviewTableViewCell.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 12/07/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit



protocol cellbuttonfunctiondelegate{
    
    func Uploadtocart(at index:IndexPath, cell:ItemsTableviewTableViewCell)
    
}

class ItemsTableviewTableViewCell: UITableViewCell {

    @IBOutlet weak var ItemNameLbl: UILabel!
    
    @IBOutlet weak var ItemPriceLbl: UILabel!
    
    @IBOutlet weak var ItemOrderBtn: UIButton!
    
    @IBOutlet weak var ItemKeylbl: UILabel!
    
    @IBOutlet weak var ItemCategoryKeyLbl: UILabel!
    
    @IBOutlet weak var itemtag: UILabel!
    
    @IBOutlet weak var StoreUidLbl: UILabel!
    
    var delegate:cellbuttonfunctiondelegate?
    var indexPath:IndexPath!
    
    @IBAction func ButtonAction(_ sender: UIButton) {
    
        print(sender.tag)
        delegate?.Uploadtocart(at: indexPath, cell: self)
    
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
