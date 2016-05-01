//
//  CustomButton.swift
//  Brain Teaser
//
//  Created by Mikael Mukhsikaroyan on 5/1/16.
//  Copyright © 2016 MSquared. All rights reserved.
//

import UIKit
import pop

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
        
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), forControlEvents: .TouchDragEnter)
        
        self.addTarget(self, action: #selector(CustomButton.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), forControlEvents: .TouchDragExit)
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        // We will be slightly scaling in the animation to 95% of original size
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        // The key is for us in case we later we want to end the animation or do something else with it. The key could be anything
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        // The velocity is how fast it will spring out and back into place
        scaleAnim.velocity  = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        // After the spring animation, we want it back to normal
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnim.springBounciness = 18
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleDefaultAnimation")
    }
    
}





