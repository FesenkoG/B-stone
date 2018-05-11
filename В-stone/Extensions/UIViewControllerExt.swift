//
//  UIViewControllerExt.swift
//  В-stone
//
//  Created by Георгий Фесенко on 30.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    func presentDetail(_ toViewController: UIViewController) {
//
//
//        let screenWidth = UIScreen.main.bounds.size.width
//        let screenHeight = UIScreen.main.bounds.size.height
//
//        toViewController.view.frame = CGRect(x: screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
//
//        let window = UIApplication.shared.keyWindow
//        window?.insertSubview(toViewController.view, aboveSubview: self.view)
//
//
//        UIView.animate(withDuration: 0.4, delay: 0, options: .beginFromCurrentState, animations: {
//            self.view.frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
//            toViewController.view.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)
//        }) { (success) in
//            CurrentUserData.instance.viewControllers.append(self)
//            self.present(toViewController, animated: false, completion: nil)
//        }
//
//    }
    
//    func dismissDetail() {
//
//        let screenWidth = UIScreen.main.bounds.size.width
//        let screenHeight = UIScreen.main.bounds.size.height
//
//        let navController = CurrentUserData.instance.viewControllers
//        print(navController)
//        if navController.count >= 1 {
////            var toViewController = navController[navController.count - 1]
//
//            if let vc = toViewController as? AdviceVC {
//                toViewController = vc
//            }
//
//            toViewController.view.frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
//
//            let window = UIApplication.shared.keyWindow
//            window?.insertSubview(toViewController.view, aboveSubview: self.view)
//
//            UIView.animate(withDuration: 0.4, delay: 0, options: .beginFromCurrentState, animations: {
//                self.view.frame = CGRect(x: screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
//                toViewController.view.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)
//            }) { (success) in
//                self.dismiss(animated: false, completion: nil)
//                _ = CurrentUserData.instance.viewControllers.popLast()
//            }
//        }
//
//    }
}
