//
//  File.swift
//  UIKit + SwiftUI
//
//  Created by Alan Yan on 2019-12-02.
//  Copyright © 2019 Alan Yan. All rights reserved.
//

import UIKit
@available(iOS 9.0, *)
extension UIView {
    
    /**
        Nest a view in its parent with padding
     */
    open func addConstraints(padding constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview = self.superview {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            
        } else {
            print("fatal error")
        }
    }
    
    /**
        Add constraints to a view with optional top, bottom, right, left anchors and constants, nested in parent by default with constants = 0
     */
    open func addConstraints(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, topPadding topConstant: CGFloat? = 0, bottomPadding bottomConstant: CGFloat? = 0, rightPadding rightConstant: CGFloat? =  0, leftPadding leftConstant: CGFloat? = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview = self.superview {
            topAnchor.constraint(equalTo: top != nil ? top!: superview.topAnchor, constant: topConstant!).isActive = true
            bottomAnchor.constraint(equalTo: bottom != nil ? bottom!:superview.bottomAnchor, constant: -bottomConstant!).isActive = true
            leftAnchor.constraint(equalTo: left != nil ? left!:superview.leftAnchor, constant: leftConstant!).isActive = true
            rightAnchor.constraint(equalTo: right != nil ? right!:superview.rightAnchor, constant: -rightConstant!).isActive = true
        } else {
            print("fatal error")
        }
    }
    
    /**
        Adds constraints using centering in the view
     */
    open func addCenteredConstraints(width: CGFloat, height: CGFloat, offSetX: CGFloat? = 0, offSetY: CGFloat? = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offSetX!).isActive = true
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offSetY!).isActive = true
        
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        
    }
    
    
    open func addShadow(colour: UIColor? = .gray, opacity: Float? = 1, offSet: CGSize? = .zero, radius: CGFloat? = 5) {
        // set the shadow of the view's layer
        clipsToBounds = false
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = colour!.cgColor
        layer.shadowOffset = offSet!
        layer.shadowOpacity = opacity!
        layer.shadowRadius = radius!
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
          
    }
    
}
