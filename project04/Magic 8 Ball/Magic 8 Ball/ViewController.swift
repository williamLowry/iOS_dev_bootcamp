//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Will Lowry on 6/4/19.
//  Copyright © 2019 Programmer Alley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ballArray = [ "ball1", "ball2", "ball3", "ball4", "ball5" ]
    var randomBallNumber = Int.random(in: 0 ... 4)
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: ballArray[randomBallNumber])
    }

    @IBAction func askButtonPressed(_ sender: Any) {
        newBallImage()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        newBallImage()
    }
    
    func newBallImage(){
        randomBallNumber = Int.random(in: 0 ... 4)
        imageView.image = UIImage(named: ballArray[randomBallNumber])
    }
    
}
