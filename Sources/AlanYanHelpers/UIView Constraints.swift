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
        Dictionary holding activated constraints, defined as the following
         - "top": topAnchor
         - "right": rightAnchor
         - "left": leftAnchor
         - "leading": leadingAnchor
         - "trailing": trailingAnchor
         - "bottom": bottomAnchor
         - "centerX": centerXAnchor
         - "centerY": centerYAnchor
         - "height": heightAnchor
         - "width": widthAnchor
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
       Constrains a view to its parent with padding in all directions
       
       Padding is defined as inwards distance, so for right and bottom, a positive padding is inwards, which is contradicting to Apple's default layout constants
       - Precondition:
         - The view must have a superview
       - Parameters:
           - padding: insets the view within its parent view by padding amount
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    open func addConstraints(padding constant: CGFloat) -> Self{
        self.translatesAutoresizingMaskIntoConstraints = false
        precondition(self.superview != nil, "This view must have a superview")
        
        userDefinedConstraintDict["top"] = topAnchor.constraint(equalTo: superview!.topAnchor, constant: constant)
        userDefinedConstraintDict["bottom"] = bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -constant)
        userDefinedConstraintDict["leading"] = leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: constant)
        userDefinedConstraintDict["trailing"] = trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -constant)
        userDefinedConstraintDict["top"]?.isActive = true
        userDefinedConstraintDict["bottom"]?.isActive = true
        userDefinedConstraintDict["leading"]?.isActive = true
        userDefinedConstraintDict["trailing"]?.isActive = true
        return self
    }
    /**
       Constrains a view to another view with padding in all directions
     
       Padding is defined as inwards distance, so for right and bottom, a positive padding is inwards, which is contradicting to Apple's default layout constants
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constrainTo: the view to constrain to
           - padding: insets the view within its parent view by padding amount
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    open func addConstraints(constrainTo view: UIView, padding constant: CGFloat) -> Self{
        self.translatesAutoresizingMaskIntoConstraints = false
        precondition(self.superview != nil, "This view must have a superview")
        
        userDefinedConstraintDict["top"] = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        userDefinedConstraintDict["bottom"] = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        userDefinedConstraintDict["leading"] = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        userDefinedConstraintDict["trailing"] = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        userDefinedConstraintDict["top"]?.isActive = true
        userDefinedConstraintDict["bottom"]?.isActive = true
        userDefinedConstraintDict["leading"]?.isActive = true
        userDefinedConstraintDict["trailing"]?.isActive = true
        return self
    }
    /**
       Add constraints to a view with optional top, bottom, right, left anchors and constants, nested in parent by default with constants = 0

       Padding is defined as inwards distance, so for right and bottom, a positive padding is inwards, which is contradicting to Apple's default layout constants
     
       - Precondition:
         - The view must have a superview
       - Parameters:
           - top: the anchor that the topAnchor will anchor to
           - bottom: the anchor that the bottomAnchor will anchor to
           - leading: the anchor that the leadingAnchor will anchor to
           - trailing: the anchor that the trailingAnchor will anchor to
           - topPadding: padding from the top anchor
           - bottomPadding: padding from the bottom anchor
           - leadingPadding: padding from the leading anchor
           - trailingPadding: padding from the trailing anchor
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    open func addConstraints(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, topPadding topConstant: CGFloat? = 0, bottomPadding bottomConstant: CGFloat? = 0, trailingPadding trailingConstant: CGFloat? =  0, leadingPadding leadingConstant: CGFloat? = 0) -> Self {
        precondition(self.superview != nil, "This view must have a superview")
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["top"] = topAnchor.constraint(equalTo: top != nil ? top!: superview!.topAnchor, constant: topConstant!)
        userDefinedConstraintDict["bottom"] = bottomAnchor.constraint(equalTo: bottom != nil ? bottom!:superview!.bottomAnchor, constant: -bottomConstant!)
        userDefinedConstraintDict["leading"] = leadingAnchor.constraint(equalTo: leading != nil ? leading!:superview!.leadingAnchor, constant: leadingConstant!)
        userDefinedConstraintDict["trailing"] = trailingAnchor.constraint(equalTo: trailing != nil ? trailing!:superview!.trailingAnchor, constant: -trailingConstant!)
        userDefinedConstraintDict["top"]?.isActive = true
        userDefinedConstraintDict["bottom"]?.isActive = true
        userDefinedConstraintDict["leading"]?.isActive = true
        userDefinedConstraintDict["trailing"]?.isActive = true
        
        return self
    }
    /**
       Constrains current view to another provided view with optional top, bottom, right, left anchors and constants, nested in parent by default with constants = 0

       Padding is defined as inwards distance, so for right and bottom, a positive padding is inwards, which is contradicting to Apple's default layout constants
     
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constrainTo: the view to constrain to
           - topPadding: padding from the top anchor
           - bottomPadding: padding from the bottom anchor
           - leadingPadding: padding from the leading anchor
           - trailingPadding: padding from the trailing anchor
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    open func addConstraints(constrainTo view: UIView, topPadding topConstant: CGFloat? = 0, bottomPadding bottomConstant: CGFloat? = 0, trailingPadding trailingConstant: CGFloat? =  0, leadingPadding leadingConstant: CGFloat? = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["top"] = topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant!)
        userDefinedConstraintDict["bottom"] = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomConstant!)
        userDefinedConstraintDict["leading"] = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant!)
        userDefinedConstraintDict["trailing"] = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailingConstant!)
        userDefinedConstraintDict["top"]?.isActive = true
        userDefinedConstraintDict["bottom"]?.isActive = true
        userDefinedConstraintDict["leading"]?.isActive = true
        userDefinedConstraintDict["trailing"]?.isActive = true
        
        return self
    }
    
    /**
       Adds a top constraint to the superviews safeAreaLayoutGuide's top anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "top"
     
       This method is meant to be used in sequence, after the superview of the view has been set using setSuperview() or someView.addSubview(thisView)
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constant: number of pixels away from the anchor, if not included it is assumed to be zero
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    @available(iOS 11.0, *)
    open func addTopSafe(constant: CGFloat? = 0) -> Self {
        precondition(self.superview != nil, "This view must have a superview")
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["top"] = topAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.topAnchor, constant: constant!)
        userDefinedConstraintDict["top"]?.isActive = true
        return self
    }
    
    /**
       Adds a left constraint to the superviews safeAreaLayoutGuide's left anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "left"
     
       This method is meant to be used in sequence, after the superview of the view has been set using setSuperview() or someView.addSubview(thisView)
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constant: number of pixels away from the anchor, if not included it is assumed to be zero
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    @available(iOS 11.0, *)
    open func addLeftSafe(constant: CGFloat? = 0) -> Self {
        precondition(self.superview != nil, "This view must have a superview")
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["left"] = leftAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.leftAnchor, constant: constant!)
        userDefinedConstraintDict["left"]?.isActive = true
        return self
    }
    /**
       Adds a right constraint to the superviews safeAreaLayoutGuide's right anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "right"
     
       This method is meant to be used in sequence, after the superview of the view has been set using setSuperview() or someView.addSubview(thisView)
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constant: number of pixels away from the anchor, if not included it is assumed to be zero
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    @available(iOS 11.0, *)
    open func addRightSafe(constant: CGFloat? = 0) -> Self {
        precondition(self.superview != nil, "This view must have a superview")
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["right"] = rightAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.rightAnchor, constant: constant!)
        userDefinedConstraintDict["right"]?.isActive = true
        return self
    }
    /**
       Adds a leading constraint to the superviews safeAreaLayoutGuide's left anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "leading"
     
       This method is meant to be used in sequence, after the superview of the view has been set using setSuperview() or someView.addSubview(thisView)
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constant: number of pixels away from the anchor, if not included it is assumed to be zero
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    @available(iOS 11.0, *)
    open func addLeadingSafe(constant: CGFloat? = 0) -> Self {
        precondition(self.superview != nil, "This view must have a superview")
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["leading"] = leftAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.leadingAnchor, constant: constant!)
        userDefinedConstraintDict["leading"]?.isActive = true
        return self
    }
    /**
       Adds a trailing constraint to the superviews safeAreaLayoutGuide's right anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "trailing"
     
       This method is meant to be used in sequence, after the superview of the view has been set using setSuperview() or someView.addSubview(thisView)
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constant: number of pixels away from the anchor, if not included it is assumed to be zero
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    @available(iOS 11.0, *)
    open func addTrailingSafe(constant: CGFloat? = 0) -> Self {
        precondition(self.superview != nil, "This view must have a superview")
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["trailing"] = rightAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.trailingAnchor, constant: constant!)
        userDefinedConstraintDict["trailing"]?.isActive = true
        return self
    }
    /**
       Adds a bottom constraint to the superviews safeAreaLayoutGuide's bottom anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "bottom"
     
       This method is meant to be used in sequence, after the superview of the view has been set using setSuperview() or someView.addSubview(thisView)
       - Precondition:
         - The view must have a superview
       - Parameters:
           - constant: number of pixels away from the anchor, if not included it is assumed to be zero
       - Returns:
           - passes through the view that called this function, a subclass of UIView
    */
    @available(iOS 11.0, *)
    open func addBottomSafe(constant: CGFloat? = 0) -> Self {
        precondition(self.superview != nil, "This view must have a superview")
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["bottom"] = bottomAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.bottomAnchor, constant: constant!)
        userDefinedConstraintDict["bottom"]?.isActive = true
        return self
    }
    /**
        Adds a top constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "top".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's top anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addTop(anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.topAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["top"] = topAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.topAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["top"]?.isActive = true
        return self
    }
    /**
        Adds a left constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "left".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's left anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addLeft(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.leftAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["left"] = leftAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.leftAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["left"]?.isActive = true
        return self
    }
    /**
        Adds a right constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "right".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's right anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addRight(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.rightAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["right"] = rightAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.rightAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["right"]?.isActive = true
        return self
    }
    /**
        Adds a leading constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "leading".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's leading anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addLeading(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.leadingAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["leading"] = leadingAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.leadingAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["leading"]?.isActive = true
        return self
    }

    /**
        Adds a trailing constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "trailing".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's trailing anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addTrailing(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.trailingAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["trailing"] = trailingAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.trailingAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["trailing"]?.isActive = true
        return self
    }
    
    /**
        Adds a bottom constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "bottom".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's bottom anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addBottom(anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.bottomAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["bottom"] = bottomAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.bottomAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["bottom"]?.isActive = true
        return self
    }
    /**
        Adds a centerX constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "centerX".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's bottom anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addCenterX(anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.centerXAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["centerX"] = centerXAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.centerXAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["centerX"]?.isActive = true
        return self
    }
    /**
        Adds a centerY constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "centerY".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's bottom anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addCenterY(anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.centerXAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["centerY"] = centerYAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.centerYAnchor : anchor!, constant: constant!)
        userDefinedConstraintDict["centerY"]?.isActive = true
        return self
    }
   /**
        Adds a height constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "height".
      
        - Precondition:
            - if anchor is not provided, the view must have a superview
        - Parameters:
            - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's height anchor
            - constant: number of pixels away from the anchor, if not included it is assumed to be zero
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addHeight(anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.heightAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["height"] = heightAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.heightAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["height"]?.isActive = true
        return self
    }
    
    /**
         Adds a width constraint to another anchor, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "width".
       
         - Precondition:
             - if anchor is not provided, the view must have a superview
         - Parameters:
             - anchor: the anchor to constrain to, if not provided it is assumed to constrain to the superview's width anchor
             - constant: number of pixels away from the anchor, if not included it is assumed to be zero
         - Returns:
             - passes through the view that called this function, a subclass of UIView
     */
    open func addWidth(anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat? = 0) -> Self {
        if(anchor == nil) {
            precondition(self.superview?.widthAnchor != nil, "This view must have a superview if no anchor is provided.")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["width"] = widthAnchor.constraint(equalTo: (anchor == nil) ? self.superview!.widthAnchor: anchor!, constant: constant!)
        userDefinedConstraintDict["width"]?.isActive = true
        return self
    }
    
    /**
        Adds a height constraint to a constant, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "height".
      
        - Parameters:
            - withConstant: number of pixels representing the height of the view
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addHeight(withConstant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["height"] = heightAnchor.constraint(equalToConstant: withConstant)
        userDefinedConstraintDict["height"]?.isActive = true
        return self
    }
    
    /**
        Adds a width constraint to a constant, sets it to active and adds the constraint to the userDefinedConstraints dictionary with key "width".
      
        - Parameters:
            - withConstant: number of pixels representing the height of the view
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addWidth(withConstant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        userDefinedConstraintDict["width"] = widthAnchor.constraint(equalToConstant: withConstant)
        userDefinedConstraintDict["width"]?.isActive = true
        return self
    }
    
    /**
        Sets background color to specified colour
     
        - Parameters:
            - color: color to change the background colour to
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func setColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    
    /**
        Adds corner radius to the current view
     
        - Warning:
            - If called directly on a ShadowUIView, the shadow will be lost, must call on the innerView
        - Parameters:
            - cornerRadius: value of corner radius
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func addCorners(_ cornerRadius: CGFloat) -> Self {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        return self
    }
    /**
        Adds corner radius to the current view on the specified corners
     
        - Parameters:
            - cornerRadius: value of corner radius
            - corners: corners to apply this cornerRadius to
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    @available(iOS 11.0, *)
    open func addCorners(radius: CGFloat, corners: CACornerMask) -> Self {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        clipsToBounds = true
        return self
    }
    /**
        Adds this view as a subview to the provided superview
     
        - Parameters:
            - superview: the superview that this view will belong to
        - Returns:
            - passes through the view that called this function, a subclass of UIView
    */
    open func setSuperview(_ superview: Any) -> Self {
        if let superview = superview as? UIView {
            superview.addSubview(self)
        }

        return self
    }
    
    /**
        Function that returns nothing, if last constraint/adjustment has been added and the result is not needed
     
        - Parameters: None
        - Returns: Void
    */
    open func done() {
    }
}
