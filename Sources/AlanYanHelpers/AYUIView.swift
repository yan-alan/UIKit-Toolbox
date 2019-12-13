//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-05.
//

import UIKit


open class AYUIView: UIView {
    
    override open class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupView() {
        
    }
}
