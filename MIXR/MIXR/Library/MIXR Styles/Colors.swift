//
//  Colors.swift
//  MIXR
//
//  Created by Michael Ciesielka on 8/22/16.
//  Copyright © 2016 MIXR LLC. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1.0)
    }
}

extension UIColor {
    class func mixrGrey() -> UIColor {
        return UIColor(r: 214, g: 214, b: 214, a: 1.0)
    }
    
    class func mixrGreen() -> UIColor {
        return UIColor(r: 127, g: 162, b: 105)
    }
}