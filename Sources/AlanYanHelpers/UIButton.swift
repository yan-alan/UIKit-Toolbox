//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-02.
//

import UIKit


extension UIButton {

    public convenience init(cornerRadius: CGFloat) {
        self.init(type: .system)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    
    public convenience init(title: String? = "", image: UIImage? = nil, cornerRadius: CGFloat? = 0, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        layer.cornerRadius = cornerRadius!
        setTitle(title!, for: .normal)
        if let action = action {
        addTarget(target, action: action, for: .touchUpInside)
        }
        if let image = image {
            setImage(image, for: .normal)
        }
        clipsToBounds = true
    }
    
        
    
}
