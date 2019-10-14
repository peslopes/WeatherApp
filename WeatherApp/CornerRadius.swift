//
//  tryingCorner.swift
//  WeatherApp
//
//  Created by Henrique Figueiredo Conte on 15/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//


import UIKit

@IBDesignable
final class cornerRadius: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 15.0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
        }
    }
    
}
