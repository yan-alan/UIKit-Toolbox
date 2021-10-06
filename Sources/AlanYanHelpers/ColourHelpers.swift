//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-04.
//

#if canImport(UIKit)
import UIKit

extension UIColor {
    
    /**
        Constructor allowing for hex values of type "0xFFFFFF"
     */
    public convenience init(hex: Int, alpha: Double? = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255, green: CGFloat((hex >> 8) & 0xFF) / 255, blue: CGFloat(hex & 0xFF) / 255, alpha: CGFloat(alpha!))
    }
}

#endif

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
extension Color {
    init(hex: Int) {
        let blue = hex % 256
        let green = (hex >> 8) % 256
        let red = (hex >> 16)
        self.init(red: Double(red)/255, green: Double(green)/255, blue: Double(blue)/255)
    }
    
    func darker() -> Color {
        return Color(color().darker())
    }
    
    func lighter() -> Color {
        return Color(color().lighter())
    }
    
    func color() -> PlatformSpecificColour {
        if #available(macOS 11.0, iOS 14.0, *) {
            return PlatformSpecificColour(self)
        }
        
        let components = self.components()
        return PlatformSpecificColour(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        
        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        
        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}


#endif

#if canImport(AppKit)
import AppKit

extension NSColor {
    public convenience init(hex: Int, alpha: Double? = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255, green: CGFloat((hex >> 8) & 0xFF) / 255, blue: CGFloat(hex & 0xFF) / 255, alpha: CGFloat(alpha!))
    }
    // Check if the color is light or dark, as defined by the injected lightness threshold.
    // Some people report that 0.7 is best. I suggest to find out for yourself.
    // A nil value is returned if the lightness couldn't be determined.
    func isLight(threshold: Float = 0.7) -> Bool? {
        let originalCGColor = self.cgColor
        
        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return nil
        }
        guard components.count >= 3 else {
            return nil
        }
        
        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }
    
    func toInt() -> Int {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return rgb
        
    }
}
#endif

extension PlatformSpecificColour {
    
    func lighter(amount : CGFloat = 0.25) -> PlatformSpecificColour {
        return hueColorWithBrightnessAmount(amount: 1 + amount)
    }
    
    func darker(amount : CGFloat = 0.25) -> PlatformSpecificColour {
        return hueColorWithBrightnessAmount(amount: 1 - amount)
    }
    
    private func hueColorWithBrightnessAmount(amount: CGFloat) -> PlatformSpecificColour {
        var hue         : CGFloat = 0
        var saturation  : CGFloat = 0
        var brightness  : CGFloat = 0
        var alpha       : CGFloat = 0
        
        #if os(iOS)
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return PlatformSpecificColour( hue: hue,
                            saturation: saturation,
                            brightness: brightness * amount,
                            alpha: alpha )
        } else {
            return self
        }
        
        #else
        
        guard let colour = usingColorSpace(.sRGB) else {
            return self
        }

        colour.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return PlatformSpecificColour( hue: hue,
                        saturation: saturation,
                        brightness: brightness * amount,
                        alpha: alpha )

        #endif
        
    }
}
