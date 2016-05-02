//
//  AnimationEngine.swift
//  Brain Teaser
//
//  Created by Mikael Mukhsikaroyan on 5/1/16.
//  Copyright © 2016 MSquared. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    class var offScreenRightPosition: CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    let animDelay = 0.8
    
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            // We will save the original constraints and then move them all off screen before the view even appears
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        // These constraints are the ones we animated off screen
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Double?) {
        
        let d = delay == nil ? animDelay * Double(NSEC_PER_SEC) : delay! * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(d))
        
        dispatch_after(time, dispatch_get_main_queue()) { 
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                // We want to move to the original place where it started. So take the constraint that is off screen and move it to its original position with custom speed bouniciness, etc
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                // Add some friction to make the animation slower
                if index > 0 {
                    moveAnim.dynamicsFriction += 10 + CGFloat(index)
                    //moveAnim.dynamicsMass = 5
                }
                
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                
                index += 1
                
            } while index < self.constraints.count
            
        }
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completionBlock: ((POPAnimation!, Bool) -> Void)!) {
        // Use this method to animate any view to any position
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springBounciness = 8
        moveAnim.springSpeed = 8
        moveAnim.completionBlock = completionBlock
        view.pop_addAnimation(moveAnim, forKey: "moveToPosition")
    }
    
}












