//
//  Shape.swift
//  Brain Teaser
//
//  Created by Mikael Mukhsikaroyan on 5/22/16.
//  Copyright © 2016 MSquared. All rights reserved.
//

import Foundation

class Shape {
    
    let shapes = ["shape1", "shape2", "shape3"]
    var currentShape: String!
    
    init() {
        selectShape()
    }
    
    func selectShape() -> String {
        currentShape = shapes[Int(arc4random_uniform(3))]
        return currentShape 
    }
    
}
