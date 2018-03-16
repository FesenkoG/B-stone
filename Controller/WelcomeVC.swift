//
//  WelcomeVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBAction func prepareForUnwindToWelcomeVC(segue: UIStoryboardSegue) {}
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "toHowOld", sender: nil)
    }
    
}
