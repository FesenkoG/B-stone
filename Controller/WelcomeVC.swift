//
//  WelcomeVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        guard let howOldVC = storyboard?.instantiateViewController(withIdentifier: "HowOldAreYouVC") as? HowOldAreYouVC else { return }
        presentDetail(howOldVC)
    }
    
}
