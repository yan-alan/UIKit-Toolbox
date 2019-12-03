//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-03.
//

import UIKit


extension UILabel {
    
    public convenience init(cornerRadius: CGFloat? = 0, align: NSTextAlignment? = .center) {
        self.init()
        layer.cornerRadius = cornerRadius!
        clipsToBounds = true
        textAlignment = align!
    }
    
    public func setFont(fontName: String? = "Futura-Bold", size: CGFloat? = 12) -> Self{
        font = UIFont(name: fontName!, size: size!)
        
        return self
    }
    
    
    
}

