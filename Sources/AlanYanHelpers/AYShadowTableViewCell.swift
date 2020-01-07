//
//  File.swift
//  
//
//  Created by Alan Yan on 2020-01-06.
//

import UIKit
@available(iOS 9.0, *)

open class AYShadowTableViewCell: UITableViewCell {
    override open class var requiresConstraintBasedLayout: Bool {
        return true
    }
    open lazy var cellView: UIView = UIView()
    open var insetValue: CGFloat = 10 {
        didSet {
            shadowView.userDefinedConstraintDict["top"]?.constant = insetValue
            shadowView.userDefinedConstraintDict["bottom"]?.constant = -insetValue
            shadowView.userDefinedConstraintDict["left"]?.constant = insetValue
            shadowView.userDefinedConstraintDict["right"]?.constant = -insetValue
        }
    }
    
    /**
        Corner radius of the cell
     */
    open var cornerRadius: CGFloat = 10 {
        didSet {
            cellView.addCorners(cornerRadius)
        }
    }
    /**
        Shadow radius of the cell
     */
    open var shadowRadius: CGFloat = 5 {
        didSet {
            shadowView.layer.shadowRadius = shadowRadius
        }
    }
    private var shadowView: ShadowUIView<UIView>!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        cellView.addCorners(cornerRadius)
        shadowView = ShadowUIView(radius: shadowRadius, subLayer: cellView).setSuperview(self).addConstraints(padding: insetValue)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
        Function for user to populate the view
     */
    open func setupView() {
        
    }
    
}
