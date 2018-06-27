//
//  HomeVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 16.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet weak var percentageLbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var prevDataLbl: UILabel!
    @IBOutlet weak var prevPercentageLbl: UILabel!
    
    var model: QuizModel!
    var bluetoothModel: BluetoothModel?
    var localDataService: LocalDataService!
    
    @IBAction func prepareForUnwindToBluetoothVC(_ segue: UIStoryboardSegue) {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        loadUserData()
        if let currentPercentsge = bluetoothModel?.currentPercentage {
            percentageLbl.text = "\(String(format:"%.01f", currentPercentsge))%"
            if let date = bluetoothModel?.date {
                dataLbl.text = date
            }
            
            if currentPercentsge >= 0 && currentPercentsge <= 29 {
                descriptionLbl.text = "dry skin"
            }
            if currentPercentsge >= 30 && currentPercentsge <= 45 {
                descriptionLbl.text = "prone to dryness skin"
            }
            if currentPercentsge >= 46 && currentPercentsge <= 60 {
                descriptionLbl.text = "normal skin"
            }
            if currentPercentsge >= 61 && currentPercentsge <= 75 {
                descriptionLbl.text = "prone to oiliness skin"
            }
            if currentPercentsge >= 76 && currentPercentsge <= 100 {
                descriptionLbl.text = "oily skin"
            }
        }
        if let prevPercentage = bluetoothModel?.prevPercentage {
            if prevPercentage == -1 {
                prevDataLbl.text = "-"
                prevPercentageLbl.text = "-"
            } else {
                prevPercentageLbl.text = "\(String(format:"%.01f", prevPercentage))%"
                if let date = bluetoothModel?.prevDate {
                    prevDataLbl.text = date
                }
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBarItem.selectedImage = UIImage(named: "hp_selected")!.withRenderingMode(.alwaysOriginal)
        AppData.shared.isHomeExists = true
        
        
    }
    
    deinit {
        AppData.shared.isHomeExists = false
    }
    
    func loadUserData() {
        let resultQuiz = localDataService.fetchQuizData()
        switch resultQuiz {
        case .success(let quiz):
            model = quiz
        case .failure(let error):
            print(error)
        }
        
        let resultBluetooth = localDataService.fetchBluetoothData()
        switch resultBluetooth {
        case .success(let bluetooth):
            bluetoothModel = bluetooth
        case .failure(let error):
            bluetoothModel = nil
            print(error)
        }
    }
    
    @IBAction func logOutBtnWasPressed(_ sender: Any) {
        let logoutPopout = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                self.localDataService.cleanStorage()
                self.performSegue(withIdentifier: "backToStart1", sender: nil)
                AppData.shared.isEditScreenExists = false
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
}
