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
    private static var _userDefinedConstraintDict = [String: [String: NSLayoutConstraint]]()
    
    /**
        Dictionary holding activated constraints
     */
    open var userDefinedConstraintDict: [String: NSLayoutConstraint] {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIView._userDefinedConstraintDict[tmpAddress] ?? ["none": widthAnchor.constraint(equalToConstant: 10)]
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIView._userDefinedConstraintDict[tmpAddress] = newValue
        }
    }

    /**
        Nest a view in its parent with padding
     */
    open func addConstraints(padding constant: CGFloat) -> Self{
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        if let superview = self.superview {
            var constraint = topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
            userDefinedConstraints["top"] = constraint
            constraint.isActive = true
            constraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
            userDefinedConstraints["bottom"] = constraint
            constraint.isActive = true
            constraint = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant)
            userDefinedConstraints["left"] = constraint
            constraint.isActive = true
            constraint = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant)
            userDefinedConstraints["right"] = constraint
            constraint.isActive = true
            
            userDefinedConstraintDict = userDefinedConstraints
        } else {
            print("View must have a superview")
        }
    
        
        return self
    }
    
    /**
        Add constraints to a view with optional top, bottom, right, left anchors and constants, nested in parent by default with constants = 0
     */
    open func addConstraints(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, topPadding topConstant: CGFloat? = 0, bottomPadding bottomConstant: CGFloat? = 0, rightPadding rightConstant: CGFloat? =  0, leftPadding leftConstant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]

        if let superview = self.superview {
            var constraint = topAnchor.constraint(equalTo: top != nil ? top!: superview.topAnchor, constant: topConstant!)
            constraint.isActive = true
            userDefinedConstraints["top"] = constraint
            constraint = bottomAnchor.constraint(equalTo: bottom != nil ? bottom!:superview.bottomAnchor, constant: -bottomConstant!)
            constraint.isActive = true
            userDefinedConstraints["bottom"] = constraint

            constraint = leftAnchor.constraint(equalTo: left != nil ? left!:superview.leftAnchor, constant: leftConstant!)
            constraint.isActive = true
            userDefinedConstraints["left"] = constraint

            constraint = rightAnchor.constraint(equalTo: right != nil ? right!:superview.rightAnchor, constant: -rightConstant!)
            constraint.isActive = true
            userDefinedConstraints["right"] = constraint

            userDefinedConstraintDict = userDefinedConstraints
        } else {
            print("View must have a superview")
        }
        
        return self
    }
    
    /**
        Add any combination of constraints
     */
    open func addConstraints(top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat? = 0, bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat? = 0, right: NSLayoutXAxisAnchor? = nil, rightConstant: CGFloat? = 0, left: NSLayoutXAxisAnchor? = nil, leftConstant: CGFloat? = 0,centerXAnchor: NSLayoutXAxisAnchor? = nil, centerYAnchor: NSLayoutYAxisAnchor? = nil, widthAnchor: NSLayoutAnchor<NSLayoutDimension>? = nil, width: CGFloat? = nil, widthConstant: CGFloat? = 0, heightAnchor: NSLayoutAnchor<NSLayoutDimension>? = nil, height: CGFloat? = nil, heightConstant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        var addedConstraints: [NSLayoutConstraint] = []
        if let top = top {
            let c = topAnchor.constraint(equalTo: top, constant: topConstant!)
            addedConstraints.append(c)
            userDefinedConstraints["top"] = c
        }
        if let bottom = bottom {
            let c = bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant!)
            addedConstraints.append(c)
            userDefinedConstraints["bottom"] = c

        }
        if let right = right {
            let c = rightAnchor.constraint(equalTo: right, constant: rightConstant!)
            addedConstraints.append(c)
            userDefinedConstraints["right"] = c
        }
        if let left = left {
            let c = leftAnchor.constraint(equalTo: left, constant: leftConstant!)
            addedConstraints.append(c)
            userDefinedConstraints["left"] = c
        }
        if let centerXAnchor = centerXAnchor {
            let c = self.centerXAnchor.constraint(equalTo: centerXAnchor)
            addedConstraints.append(c)
            userDefinedConstraints["centerX"] = c
        }
        if let centerYAnchor = centerYAnchor {
            let c = self.centerYAnchor.constraint(equalTo: centerYAnchor)
            addedConstraints.append(c)
            userDefinedConstraints["centerY"] = c
        }
        if let widthAnchor = widthAnchor {
            let c = self.widthAnchor.constraint(equalTo: widthAnchor, constant: widthConstant!)
            addedConstraints.append(c)
            userDefinedConstraints["width"] = c
        } else if let width = width {
            let c = self.widthAnchor.constraint(equalToConstant: width)
            addedConstraints.append(c)
            userDefinedConstraints["width"] = c
        }
        if let heightAnchor = heightAnchor {
            let c = self.heightAnchor.constraint(equalTo: heightAnchor, constant: heightConstant!)
            addedConstraints.append(c)
            userDefinedConstraints["width"] = c
        } else if let height = height {
            let c = self.heightAnchor.constraint(equalToConstant: height)
            addedConstraints.append(c)
            userDefinedConstraints["width"] = c
        }
        
        for constraint in addedConstraints {
            constraint.isActive = true
        }
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    
    
    /**
        Adds constraints to the superviews center anchor
     */
    open func addCenteredConstraints(width: CGFloat, height: CGFloat, offSetX: CGFloat? = 0, offSetY: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        var c = centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offSetX!)
        c.isActive = true
        userDefinedConstraints["centerX"] = c
        c = centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offSetY!)
        c.isActive = true
        userDefinedConstraints["centerY"] = c

        c = heightAnchor.constraint(equalToConstant: height)
        c.isActive = true
        userDefinedConstraints["height"] = c
        
        c = widthAnchor.constraint(equalToConstant: width)
        c.isActive = true
        userDefinedConstraints["width"] = c
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    
    /**
           Adds a top constraint to another anchor
    */
    open func addTop(anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict

        let c = topAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.topAnchor: anchor!, constant: constant!)
        userDefinedConstraints["top"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    /**
           Adds a left constraint to another anchor
    */
    open func addLeft(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = leftAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.leftAnchor: anchor!, constant: constant!)
        userDefinedConstraints["left"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    /**
           Adds a right constraint to another anchor
    */
    open func addRight(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = rightAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.rightAnchor: anchor!, constant: constant!)
        userDefinedConstraints["right"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    /**
           Adds a leading constraint to another anchor
    */
    open func addLeading(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = leadingAnchor.constraint(equalTo: anchor!, constant: constant!)
        userDefinedConstraints["leading"] = c
        c.isActive = true

        userDefinedConstraintDict = userDefinedConstraints

        return self
    }

    /**
           Adds a trailing constraint to another anchor
    */
    open func addTrailing(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = trailingAnchor.constraint(equalTo: anchor!, constant: constant!)
        userDefinedConstraints["trailing"] = c
        c.isActive = true

        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    
    /**
           Adds a bottom constraint to another anchor
    */
    open func addBottom(anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = bottomAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.bottomAnchor: anchor!, constant: constant!)
        userDefinedConstraints["bottom"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    
    /**
           Adds a height constraint to another anchor
    */
    open func addHeight(anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = heightAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.heightAnchor: anchor!, constant: constant!)
        userDefinedConstraints["height"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    
    /**
        Adds a width constraint to another anchor
     */
    open func addWidth(anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = widthAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.widthAnchor: anchor!, constant: constant!)
        userDefinedConstraints["width"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    
    /**
       Adds a height constraint set to a constant
    */
    open func addHeight(withConstant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = heightAnchor.constraint(equalToConstant: withConstant)
        userDefinedConstraints["height"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    
    /**
        Adds a width constraint set to a constant
     */
    open func addWidth(withConstant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        var userDefinedConstraints: [String: NSLayoutConstraint] = [:]
        userDefinedConstraints = userDefinedConstraintDict
        
        let c = widthAnchor.constraint(equalToConstant: withConstant)
        userDefinedConstraints["width"] = c
        c.isActive = true
        
        userDefinedConstraintDict = userDefinedConstraints

        return self
    }
    /**
        Sets background colour on the view
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
    
    /**
        Call to return void, once all constraints are added/modification completed
     */
    open func done() {
    }
}
