//
//  BorderedButton.swift
//  MIXR
//
//  Created by Nilesh Patel on 24/10/15.
//  Copyright © 2015 MIXR LLC. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class BorderedButton : UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        self.setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    func setup() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: (214.0/255.0), green: (214.0/255.0), blue: (214.0/255.0), alpha: 1).CGColor
        self.titleLabel?.font = UIFont(name: "ForgottenFuturistRg-Regular", size: 24)
    }
}