//
//  AdviceVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 16.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import Firebase

class AdviceVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    
    var model: QuizModel!
    var bluetoothModel: [BluetoothInfo]?
    
    let articlesWithProducts = ["2", "4", "7", "15", "16"]
    let articlesWithoutImages = ["101", "102"]
    
    
    var isReadMore = [String: Bool]()
    
    //MARK: - Services
    var localDataService: LocalDataService! = LocalDataService()
    
    @IBAction func prepareForUnwindHey(segue: UIStoryboardSegue) {
        let vc = segue.destination as! AdviceVC
        vc.tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
        articles.removeAll()
        let base = "article"
        let numbersToShow = articlesToShow()
        for number in numbersToShow {
            let imageName = String(describing: number)
            let newBase = base + imageName
            let filePath = Bundle.main.path(forResource: newBase, ofType: "txt")!
            do {
                let text = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                let sepStr = text.components(separatedBy: ";")
                let header = sepStr[0]
                let preview = sepStr[1]
                let body = sepStr[2]
                
                let article = Article(header: header, preview: preview, body: body, imageName: imageName)
                articles.append(article)
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 465
        
        self.tabBarItem.selectedImage = UIImage(named: "advice_selected")!.withRenderingMode(.alwaysOriginal)
        
    }
    
    func articlesToShow() -> [Int] {
        //Возвращает набор индексов статей для показа,  основываясь на данных пользователя
        var result = [Int]()
        result.append(12)
        result.append(101)
        result.append(102)
        if checkFirst() {
            result.append(1)
            result.append(2)
            result.append(3)
            
        }
        
        if model.habitSmoking {
            result.append(4)
        }
        
        if model.age >= 25 {
            result.append(5)
        }
        
        if let allergen = model.allergic {
            if allergen == .haveNotKnow || allergen == .notKnow {
                result.append(6)
            }
        }
        
        if checkForInflamations() {
            result.append(7)
        }
        
        if model.habitTravelling {
            result.append(8)
        }
        
        if model.habitMakeup {
            result.append(11)
        }
        
        if checkForThirteen() {
            result.append(13)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let m = Int(formatter.string(from: Date()))!
        if m == 11 || m == 12 || m == 1 || m == 2 {
            result.append(14)
        }
        
        
        if let currentPercentageArray = bluetoothModel?.last?.measuredData {
            let currentPercentage = (currentPercentageArray.reduce(0, +) / 3.0)
            if currentPercentage > 0 && currentPercentage <= 45 {
                result.append(15)
            }
            if currentPercentage >= 61 && currentPercentage <= 100 {
                result.append(16)
            }
        }
        
        return result
    }

    func checkFirst() -> Bool {
        if model.habitSunbathing {
            return true
        }
        
        if model.age >= 19, model.age <= 25 {
            if model.wrinklesForehead{
                return true
            }
        }
        if let lifeStyle = model.placeOfLiving {
            if lifeStyle == .mountain || lifeStyle == .sea {
                return true
            }
        }
        
        return false
    }
    
    func checkForInflamations() -> Bool {
        return model.inflamationsAroundNose || model.inflamationsForehead || model.inflamationsCheeks || model.inflamationsNose || model.inflamationsChin
    }
    
    func checkForThirteen() -> Bool {
        if model.habitSmoking || model.habitCoffee || model.habitTravelling || model.age >= 25 {
            return true
        }
        
        if let lyfestyle = model.placeOfLiving {
            if lyfestyle == .mountain || lyfestyle == .sea {
                return true
            }
        }
        return false
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
                self.performSegue(withIdentifier: "backToStart2", sender: nil)
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

//MARK: - TableViewDelegates
extension AdviceVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var flag = false
        if let fullTextFlag = isReadMore[articles[indexPath.row].imageName] {
            if fullTextFlag == true {
                flag = false
            } else {
                flag = true
            }
        }
    
        if articlesWithProducts.contains(articles[indexPath.row].imageName) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleWithProductsCell") as? ArticleWithProductsCell else { return UITableViewCell() }
            let article = Article(header: articles[indexPath.row].header, preview: articles[indexPath.row].preview, body: articles[indexPath.row].body, imageName: articles[indexPath.row].imageName)
            cell.configureCell(article: article, fullText: flag, indexPath: indexPath)
            cell.delegate = self
            
            return cell
        } else if articlesWithoutImages.contains(articles[indexPath.row].imageName) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleWithoutImageCell") as? ArticleWithoutImageCell else { return UITableViewCell() }
            let article = Article(header: articles[indexPath.row].header, preview: articles[indexPath.row].preview, body: articles[indexPath.row].body, imageName: articles[indexPath.row].imageName)
            cell.configureCell(article: article, fullText: flag, indexPath: indexPath)
            cell.delegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as? ArticleCell else { return UITableViewCell() }
            let article = Article(header: articles[indexPath.row].header, preview: articles[indexPath.row].preview, body: articles[indexPath.row].body, imageName: articles[indexPath.row].imageName)
            cell.configureCell(article: article, fullText: flag, indexPath: indexPath)
            cell.delegate = self
            
            return cell
        }
        
    }
    
}

//MARK: - CellDelegate
extension AdviceVC: CellChangingProtocol {
    func cellDidChange(article: String, _ indexPath: IndexPath?) {
        if isReadMore[article] == nil {
            isReadMore[article] = false
        } else if isReadMore[article] == false {
            isReadMore[article] = true
        } else {
            isReadMore[article] = false
        }
        
        tableView.beginUpdates()
        if let indexPath = indexPath {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        tableView.endUpdates()
    }
    
    
}
