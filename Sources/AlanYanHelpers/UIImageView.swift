//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-02.
//

import UIKit

open class ContentFitImageView: UIImageView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
        
    }
    
    public override init(image: UIImage?) {
        super.init(image: image)
        contentMode = .scaleAspectFit
        
    }
    
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        contentMode = .scaleAspectFit
        
    }
    
    convenience public init(image: UIImage?, cornerRadius: CGFloat) {
        self.init(image:image)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
