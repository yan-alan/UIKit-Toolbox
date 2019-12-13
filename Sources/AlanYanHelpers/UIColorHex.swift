//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-04.
//

import UIKit

extension UIColor {
    
    /**
        Constructor allowing for hex values of type "0xFFFFFF"
     */
    public convenience init(hex: Int, alpha: Double? = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255, green: CGFloat((hex >> 8) & 0xFF) / 255, blue: CGFloat(hex & 0xFF) / 255, alpha: CGFloat(alpha!))
    }
}
