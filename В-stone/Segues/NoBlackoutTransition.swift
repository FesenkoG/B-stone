//
//  NoBlackoutTransition.swift
//  В-stone
//
//  Created by Георгий Фесенко on 15.03.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class NoBlackoutTransition: UIStoryboardSegue {
    override func perform() {
        transition()
    }
    
    func transition() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        toViewController.view.frame = CGRect(x: screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .beginFromCurrentState, animations: {
            fromViewController.view.frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
            toViewController.view.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)
        }) { (success) in
            fromViewController.present(toViewController, animated: false, completion: nil)
        }
    }
}

class UnwindNoBlackoutTransition:UIStoryboardSegue {
    override func perform() {
        transition()
    }
    
    func transition() {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        let toViewController = self.destination
        let fromViewController = self.source


        toViewController.view.frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: screenHeight)

        let window = UIApplication.shared.keyWindow
        window?.insertSubview(toViewController.view, aboveSubview: fromViewController.view)

        UIView.animate(withDuration: 0.4, delay: 0, options: .beginFromCurrentState, animations: {
            fromViewController.view.frame = CGRect(x: screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
            toViewController.view.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)
        }) { (success) in
            fromViewController.dismiss(animated: false, completion: nil)
        }
    }
}

