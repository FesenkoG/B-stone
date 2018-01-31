//
//  LifestyleVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 30.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class LifestyleVC: UIViewController {
    
    
    @IBOutlet weak var sunbathingAcceptedBtn: UIButton!
    @IBOutlet weak var sportAcceptedBtn: UIButton!
    @IBOutlet weak var makeupAcceptedBtn: UIButton!
    @IBOutlet weak var smokingAcceptedBtn: UIButton!
    @IBOutlet weak var dietAcceptedBtn: UIButton!
    @IBOutlet weak var coffeeAcceptedBtn: UIButton!
    
    var sunbathingAccepted = false
    var sportAccepted = false
    var makeupAccepted = false
    var smokingAccepted = false
    var dietAccepted = false
    var coffeeAccepted = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var backBtnWasPressed: UIButton!
}
