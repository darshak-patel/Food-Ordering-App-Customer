//
//  HomescreenCollectionViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 04/05/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit

class HomescreenCollectionViewController: UICollectionViewController {
    
    
    
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        
        let item = CollData[indexPath.item]
        
        cell.nearbyuimageview.image = item["foodimage"] as? UIImage
        cell.nearbyRestName.text = "\(item["Restname"]!)"
         cell.nearbyRestType.text = "\(item["RestType"]!)"
         cell.nearbyRestName.text = "\(item["RestLocation"]!)"
        
        
    
        return cell
    }

   

}
