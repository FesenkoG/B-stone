//
//  SettingsVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 16.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBarItem.selectedImage = UIImage(named: "settings_selected")!.withRenderingMode(.alwaysOriginal)
    }

    @IBAction func logOutBtnWasPressed(_ sender: Any) {
        let logoutPopout = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                guard let startVC = self.storyboard?.instantiateViewController(withIdentifier: "StartVC") as? StartVC else { return }
                self.present(startVC, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logoutPopout.addAction(logoutAction)
        present(logoutPopout, animated: true) {
            logoutPopout.view.superview?.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissAllert))
            logoutPopout.view.superview?.addGestureRecognizer(tap)
        }
    }
    
    @objc func dismissAllert() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editProfileDataWasPressed(_ sender: Any) {
        guard let howOldAreYouVC = self.storyboard?.instantiateViewController(withIdentifier: "HowOldAreYouVC") as? HowOldAreYouVC else { return }
        
        self.present(howOldAreYouVC, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteAccountBtnWasPressed(_ sender: Any) {
        let logoutPopout = UIAlertController(title: "Delete account?", message: "Are you sure you want to delete account?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Delete?", style: .destructive) { (buttonTapped) in
            Auth.auth().currentUser?.delete(completion: { (error) in
                if error == nil {
                    guard let startVC = self.storyboard?.instantiateViewController(withIdentifier: "StartVC") as? StartVC else { return }
                    self.present(startVC, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription as Any)
                }
            })
        }
        
        logoutPopout.addAction(logoutAction)
        present(logoutPopout, animated: true) {
            logoutPopout.view.superview?.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissAllert))
            logoutPopout.view.superview?.addGestureRecognizer(tap)
        }
        
    }
}
