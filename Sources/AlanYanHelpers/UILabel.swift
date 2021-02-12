//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-03.
//

import UIKit


extension UILabel {
    
    public convenience init(text: String? = "", cornerRadius: CGFloat? = 0, align: NSTextAlignment? = .center) {
        self.init()
        layer.cornerRadius = cornerRadius!
        clipsToBounds = true
        textAlignment = align!
        self.text = text!
        
    }
    
    /**
        Set's font of a UILabel using a name and a size
     */
    @discardableResult
    public func setFont(name: String? = "Futura-Bold", size: CGFloat? = 12) -> Self {
        font = UIFont(name: name!, size: size!)
        
        return self
    }
    
    /**
        Sets text of a UILabel
     */
    public func setText(_ text: String) {
        self.text = text
    }
    
    
    
}

