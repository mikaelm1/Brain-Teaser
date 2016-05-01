//
//  CustomButton.swift
//  Brain Teaser
//
//  Created by Mikael Mukhsikaroyan on 5/1/16.
//  Copyright © 2016 MSquared. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.blackColor() {
        didSet {
            self.tintColor = fontColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        
    }
    
}
