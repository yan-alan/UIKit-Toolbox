//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-04.
//

import UIKit


/**
 class that adds a shadow as the highest level view and adds a subview of any type stored in the var innerView
 */
@available(iOS 9.0, *)
open class ShadowUIView<T: UIView>: UIView {
    open var innerView: T!
    
    public convenience init(colour: UIColor? = .gray, opacity: Float? = 1, offSet: CGSize? = .zero, radius: CGFloat? = 5, subLayer: T) {
        // set the shadow of the view's layer
        self.init()
        clipsToBounds = false
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = colour!.cgColor
        layer.shadowOffset = offSet!
        layer.shadowOpacity = opacity!
        layer.shadowRadius = radius!
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        self.innerView = subLayer
        
        addSubview(subLayer)
        
        subLayer.addConstraints(padding: 0).done()
      
        
    }
}
