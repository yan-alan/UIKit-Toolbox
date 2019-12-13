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
    open func addConstraints(padding constant: CGFloat) -> Self{
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview = self.superview {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            
        } else {
            print("fatal error")
        }
    
        
        return self
    }
    
    /**
        Add constraints to a view with optional top, bottom, right, left anchors and constants, nested in parent by default with constants = 0
     */
    open func addConstraints(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, topPadding topConstant: CGFloat? = 0, bottomPadding bottomConstant: CGFloat? = 0, rightPadding rightConstant: CGFloat? =  0, leftPadding leftConstant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview = self.superview {
            topAnchor.constraint(equalTo: top != nil ? top!: superview.topAnchor, constant: topConstant!).isActive = true
            bottomAnchor.constraint(equalTo: bottom != nil ? bottom!:superview.bottomAnchor, constant: -bottomConstant!).isActive = true
            leftAnchor.constraint(equalTo: left != nil ? left!:superview.leftAnchor, constant: leftConstant!).isActive = true
            rightAnchor.constraint(equalTo: right != nil ? right!:superview.rightAnchor, constant: -rightConstant!).isActive = true
        } else {
            print("fatal error")
        }
        
        return self
    }
    
    /**
        Add any combination of constraints
     */
    open func addConstraints(top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat? = 0, bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat? = 0, right: NSLayoutXAxisAnchor? = nil, rightConstant: CGFloat? = 0, left: NSLayoutXAxisAnchor? = nil, leftConstant: CGFloat? = 0,centerXAnchor: NSLayoutXAxisAnchor? = nil, centerYAnchor: NSLayoutYAxisAnchor? = nil, widthAnchor: NSLayoutAnchor<NSLayoutDimension>? = nil, width: CGFloat? = 0, widthConstant: CGFloat? = 0, heightAnchor: NSLayoutAnchor<NSLayoutDimension>? = nil, height: CGFloat? = nil, heightConstant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant!).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant!).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: rightConstant!).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant!).isActive = true
        }
        if let centerXAnchor = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        if let centerYAnchor = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        if let widthAnchor = widthAnchor {
            self.widthAnchor.constraint(equalTo: widthAnchor, constant: widthConstant!).isActive = true
        } else if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let heightAnchor = heightAnchor {
            self.heightAnchor.constraint(equalTo: heightAnchor, constant: heightConstant!).isActive = true
        } else if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        return self
    }
    
    
    /**
        Adds constraints to the superviews center anchor
     */
    open func addCenteredConstraints(width: CGFloat, height: CGFloat, offSetX: CGFloat? = 0, offSetY: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offSetX!).isActive = true
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offSetY!).isActive = true
        
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    /**
        Sets background colour on any view
     */
    open func setColor(_ colour: UIColor) {
        backgroundColor = colour
        
    }
    
    
    /**
        Adds corners to the layer
     */
    open func addCorners(_ cornerRadius: CGFloat) -> Self {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        return self
    }
    /**
        Sets the superview of the view to a new view
     */
    open func setSuperview(_ superview: Any) -> Self {
        if let superview = superview as? UIView {
            superview.addSubview(self)
        }

        return self
    }
    
}
