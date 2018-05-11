//
//  ItWasSentVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class ItWasSentVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 0, 0, 25)
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToStart", sender: nil)
    }
}
