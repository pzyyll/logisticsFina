//
//  CAGradientLayer.swift
//  logistics
//
//  Created by 张轾林 on 16/3/17.
//  Copyright © 2016年 张轾林. All rights reserved.
//

import UIKit


extension CAGradientLayer {
    
    func GradientLayer() -> CAGradientLayer {
        
        let topColor = UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        //UIColor(red: 0.0/255.0, green: 154.0/255.0, blue: 97.0/255.0, alpha: 1.0)
        
        let buttomColor = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, buttomColor.CGColor]
        let gradientLocations: [CGFloat] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
        
    }
}