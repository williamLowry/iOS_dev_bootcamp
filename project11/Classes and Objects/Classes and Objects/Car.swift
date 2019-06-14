//
//  Car.swift
//  Classes and Objects
//
//  Created by Will Lowry on 6/12/19.
//  Copyright © 2019 Programmer Alley. All rights reserved.
//

import Foundation

enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    
    var colour = "Black"
    var numberOfSeats = 5
    var typeOfCar : CarType = .Coupe
    
    init(  ) {

    }
    
    convenience init (customerChosenColour : String) {
        self.init()
        colour = customerChosenColour
    }
    
    func drive () {
        print("car is moving")
    }
    
}
