//
//  GameVC.swift
//  Brain Teaser
//
//  Created by Mikael Mukhsikaroyan on 5/1/16.
//  Copyright © 2016 MSquared. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var currentCard: Card!
    var shape: Shape!
    var currentShape: String!
    var previousShape: String!
    var answer = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        
        // the center of our card is the center of the screen
        currentCard.center = AnimationEngine.screenCenterPosition
        
        shape = Shape()
        currentShape = shape.selectShape()
        previousShape = ""
        currentCard.shapeImage.image = UIImage(named: currentShape)
        
        self.view.addSubview(currentCard)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            answer = "yes"
            checkAnswer()
        } else {
            titleLabel.text = "Does this card match the previous?"
        }
        showNextCard()
    }
    
    @IBAction func noPressed(sender: UIButton) {
        answer = "no"
        checkAnswer()
        showNextCard()
    }
    
    func checkAnswer() {
        if answer == "yes" {
            if currentShape == previousShape {
                print("Correct")
            } else {
                print("Wrong")
            }
        } else if answer == "no" {
            if currentShape != previousShape {
                print("Correct")
            } else {
                print("Wrong")
            }
        }
    }
    
    func showNextCard() {
        // DO NOT DO DATA MANIPULATION IN YOUR ANIMATION CALLBACKS BECAUSE IT IS ASYNCHRONOUS AND SO CAN BE DANGEROUS
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completionBlock: { (animation, finished) in
                
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            // As soon as we create the new card, we throw it off screen
            next.center = AnimationEngine.offScreenRightPosition
            next.frame.size = fitCardToScreen()
            previousShape = currentShape
            currentShape = shape.selectShape()
            next.shapeImage.image = UIImage(named: currentShape)
            self.view.addSubview(next)
            currentCard = next
            
            if noButton.hidden {
                noButton.hidden = false
                yesButton.setTitle("YES", forState: .Normal)
            }
            
            let pos = CGPointMake(UIScreen.mainScreen().bounds.width * 0.5, UIScreen.mainScreen().bounds.height * 0.5)
            AnimationEngine.animateToPosition(next, position: pos, completionBlock: { (animation, finished) in
                // do something 
            })
        }
    }
    
    func createCardFromNib() -> Card? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    func fitCardToScreen() -> CGSize {
        let screen = UIScreen.mainScreen().bounds
        return CGSizeMake(screen.width * 0.8, screen.height * 0.4)
    }
    

    

}
