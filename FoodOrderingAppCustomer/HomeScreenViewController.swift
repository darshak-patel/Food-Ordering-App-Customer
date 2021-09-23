//
//  HomeScreenViewController.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 02/05/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase


class HomeScreenViewController: UIViewController,iCarouselDataSource,iCarouselDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate{
    
    
    
    //Collection View For Nearby Restaurants
    
    var NBRdataarray = [NearByRestaurants]()
    var uidarray = [uidsforcell]()
    
    func fetchuserNBR(){
        Database.database().reference().child("storedata").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                let NBRcelldata = NearByRestaurants()
                let uids = uidsforcell()
                
               
                NBRcelldata.storename = dictionary["storename"] as? String
                NBRcelldata.foodimageurl = dictionary["profileimageurl"] as? String
                NBRcelldata.storearea = dictionary["storearea"] as? String
                NBRcelldata.storecategories = dictionary["storecategories"] as? String
                NBRcelldata.key = dictionary["key"] as? String
                uids.key = dictionary["key"] as? String
                
                self.NBRdataarray.append(NBRcelldata)
                self.uidarray.append(uids)
                
                DispatchQueue.main.async {
                    self.collectionviewNR.reloadData()
                }//dispatchqueue
                
            }
            
        })
        
    }
    
    
    let CollData = [
        
        ["foodimage":#imageLiteral(resourceName: "foodphoto1"),"Restname":"Dessert Garden Restaurant","RestType":"Gujarati","RestLocation":"RANIP"],
        ["foodimage":#imageLiteral(resourceName: "foodphoto2"),"Restname":"Armane","RestType":"Gujarati,Chinese","RestLocation":"CHANDKHEDA"],
        ["foodimage":#imageLiteral(resourceName: "foodphoto3"),"Restname":"Eat Punjab","RestType":"North Indian","RestLocation":"ADALAJ"],
        ["foodimage":#imageLiteral(resourceName: "foodphoto4"),"Restname":"Indian Sweets","RestType":"Sweets","RestLocation":"INFOCITY"],
        ["foodimage":#imageLiteral(resourceName: "foodphoto5"),"Restname":"Dhosa Hub","RestType":"South Indian","RestLocation":"CHANDKHEDA"],
        ["foodimage":#imageLiteral(resourceName: "foodphoto7"),"Restname":"Creamistry","RestType":"Ice-Cream","RestLocation":"GOTA"],
        ["foodimage":#imageLiteral(resourceName: "foodphoto6"),"Restname":"Baskin Robins","RestType":"Ice-Cream","RestLocation":"KALOL"]
        
        
        
        ]
    //collection view data for RFY
    let RFYcellData = [
    
    ["RFYCellBackground":#imageLiteral(resourceName: "FoodPhotoRecc1"),"RFYCellTitle":"Trending This Week"],
     ["RFYCellBackground":#imageLiteral(resourceName: "FoodPhotoRecc2"),"RFYCellTitle":"Hanging Out"],
      ["RFYCellBackground":#imageLiteral(resourceName: "FoodPhotoRecc3"),"RFYCellTitle":"Natures Way"],
       ["RFYCellBackground":#imageLiteral(resourceName: "FoodPhotoRecc4"),"RFYCellTitle":"Sweet Delicasies"],
        ["RFYCellBackground":#imageLiteral(resourceName: "FoodPhotoRecc5"),"RFYCellTitle":"Unique Dining"],
         ["RFYCellBackground":#imageLiteral(resourceName: "FoodPhotoRecc6"),"RFYCellTitle":"Italian"],
    
    
    
    ]

    
    //Data for CuisineCV
    let cuisineData = [
    
        ["CuisineImage":#imageLiteral(resourceName: "Cuisines1")],
         ["CuisineImage":#imageLiteral(resourceName: "Cuisines2")],
         ["CuisineImage":#imageLiteral(resourceName: "Cuisines3")],
         ["CuisineImage":#imageLiteral(resourceName: "Cuisines4")],
         ["CuisineImage":#imageLiteral(resourceName: "Cuisines5")],
         ["CuisineImage":#imageLiteral(resourceName: "Cuisines6")]
    
    ]
    
    
    //Storyboard IDs
    let storyBID = ["DesertGarden"]
   
    @IBOutlet weak var collectionviewNR: UICollectionView!
    
    @IBOutlet weak var collectionviewRFY: UICollectionView!

    
    @IBOutlet weak var collectionviewCuisines: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionviewNR{
        return NBRdataarray.count
        }
        if collectionView == self.collectionviewRFY {
             return RFYcellData.count
        }
        else{
           return cuisineData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionviewNR{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        
        let item = NBRdataarray[indexPath.item]
        
        let imageurl = item.foodimageurl
            
            
            
            cell.nearbyuimageview.image = UIImage(named: "FoodPhotoRecc1")
            
            cell.nearbyuimageview.loadimagecache(urlstring: imageurl!)
            
        cell.nearbyRestName.text = item.storename
        cell.nearbyRestType.text = item.storecategories
        cell.nearbyLocation.text = item.storearea
            
            return cell
        }
        
        if collectionView == self.collectionviewRFY{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! RFYCollectionViewCell
            
            let item = RFYcellData[indexPath.item]
            
            cell1.RFYImageView.image = item["RFYCellBackground"] as? UIImage
            cell1.RFYcellTitle.text = "\(item["RFYCellTitle"]!)"
            cell1.rfycellShadow.text = "\(item["RFYCellTitle"]!)"
            
            
            
            return cell1
            
        }
        
        else{
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! CuisineCollectionViewCell
            
            
            let item = cuisineData[indexPath.item]
            
            cell3.imageCuisine.image = item["CuisineImage"]
        
            
            return cell3
            
        }
        
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionviewNR {
            let selectedKey = uidarray[indexPath.row]
            print(selectedKey.key!)
            
            performSegue(withIdentifier: "PresentStore", sender: indexPath.row)
        }
        
        else{
            let dsgvc = self.storyboard?.instantiateViewController(withIdentifier: "DesertGarden") as? DSGViewController
            
            present(dsgvc!, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "PresentStore"{
            let selectedRow = sender as? Int
            
            let destination = segue.destination as? DSGViewController
            
            if let uidkeyname = NBRdataarray[selectedRow!].key{
                
                
                print("PRINTING NAME: \(uidkeyname)")
                
                destination?.uidkey = uidkeyname
                
            }
        }
    }
    
    
 
    
    //icarousel
        let arrimages = [
    UIImage(named: "Ad1"),
    UIImage(named: "Ad2"),
    UIImage(named: "Ad3"),
    UIImage(named: "Ad4")
    ]
    
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return arrimages.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var images:UIImageView!
        if view == nil{
            images = UIImageView(frame: CGRect(x:0 , y: 0, width: 300, height: 250))
            images.contentMode = .scaleAspectFit
            
        }
        else{
            images = view as? UIImageView
        }
        images.image = arrimages[index]
        return images
    }
    
    
    

    
    
    @IBOutlet var iCaroselview: iCarousel!
    
    @IBOutlet weak var searchtxtfield: UITextField!
    
    //Resigning Textfield Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
 
    
   /*  @IBAction func notify(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Bites"
        content.subtitle = "Uponhibhagwanhai"
        content.body = "you will be sued in the court of ordering the food from this app"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }*/
       
 
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
        //FetchDataForNBR
            fetchuserNBR()
        
        //ScrollView For Nearby Restaurants
        
        collectionviewNR.delegate = self
        collectionviewRFY.delegate = self
        
        collectionviewNR.dataSource = self
    
        collectionviewRFY.dataSource = self
            
        collectionviewCuisines.delegate = self
        collectionviewCuisines.dataSource = self
        
        /*self.view.addSubview(collectionviewRFY)
        self.view.addSubview(collectionviewNR)*/
        
        
        
        
        //icarousel
        
        iCaroselview.type = .coverFlow2
        iCaroselview.contentMode = .scaleAspectFill
        
        //notification
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound,.badge], completionHandler:{didAllow, error in })
        
        //TextFieldSearchBar
        let image = UIImageView()
        image.frame=CGRect(x:0, y: 10, width: 20, height: 20)
        let image2 = #imageLiteral(resourceName: "Search1")
        image.image = image2
        searchtxtfield.rightView=image
            
        searchtxtfield.rightViewMode = .always
        
        image.clipsToBounds = true
        
        
            
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
}

