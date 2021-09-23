//
//  Emitter.swift
//  FoodOrderingAppCustomer
//
//  Created by Prajval Raval on 05/05/1940 Saka.
//  Copyright © 1940 Prajval Raval. All rights reserved.
//

import Foundation

class Emitter {
    
    static func get(with image:UIImage) -> CAEmitterLayer{
        
        
        
    let emitter  = CAEmitterLayer()
        emitter.emitterShape = kCAEmitterLayerPoint
        
        emitter.emitterCells = generateEmitterCells(with: image)
        
        
        
        
        return emitter
    
    
    }
    
    
    static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell]{
        var cells = [CAEmitterCell]()
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 1
        cell.lifetime = 500
        cell.velocity = CGFloat(500)
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionLatitude = (45 * (.pi/180))
       
        cell.scale = 1
        
        cells.append(cell)
        
        
        
        return cells
    }
}
