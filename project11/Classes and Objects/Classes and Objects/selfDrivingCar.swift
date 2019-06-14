//
//  Self Driving Car.swift
//  Classes and Objects
//
//  Created by Will Lowry on 6/12/19.
//  Copyright © 2019 Programmer Alley. All rights reserved.
//

import Foundation

class selfDrivingCar : Car {
    
    var destination : String?

    override func drive(){
        super.drive()
        
        if let userSetDestination = destination {
            print("driving towards " + userSetDestination)
        }
    }
    
}

