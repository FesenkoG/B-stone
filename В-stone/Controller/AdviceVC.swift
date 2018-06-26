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
    let articlesWithProducts = ["2", "4", "7", "15", "16"]
    let articlesWithoutImages = ["101", "102"]
    
    var isReadMore = [String: Bool]()
    
    @IBAction func prepareForUnwindHey(segue: UIStoryboardSegue) {
        let vc = segue.destination as! AdviceVC
        vc.tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        if let smoking = CurrentUserData.instance.habitSmoking, smoking == true {
            result.append(4)
        }
        
        if let age = CurrentUserData.instance.age, age >= 25 {
            result.append(5)
        }
        
        if let allergen = CurrentUserData.instance.allergic {
            if allergen == .haveNotKnow || allergen == .notKnow {
                result.append(6)
            }
        }
        
        if checkForInflamations() {
            result.append(7)
        }
        
        if let sport = CurrentUserData.instance.habitSport, sport == true {
            result.append(8)
        }
        
        if let makeup = CurrentUserData.instance.habitMakeup, makeup == true {
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
        
        
        if let currentPercentage = CurrentUserData.instance.currentPercantage {
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
        if let sunbathing = CurrentUserData.instance.habitSunbathing, sunbathing == true {
            return true
        }
        
        if let age = CurrentUserData.instance.age, age >= 19, age <= 25 {
            if let forehead = CurrentUserData.instance.wrinklesForehead, forehead == true {
                return true
            }
        }
        if let lifeStyle = CurrentUserData.instance.placeOfLiving {
            if lifeStyle == .mountain || lifeStyle == .sea {
                return true
            }
        }
        
        return false
    }
    
    func checkForInflamations() -> Bool {
        if let bubble = CurrentUserData.instance.inflamationsChin, bubble == true {
            return true
        }
        if let bubble = CurrentUserData.instance.inflamationsNose, bubble == true {
            return true
        }
        if let bubble = CurrentUserData.instance.inflamationsCheeks, bubble == true {
            return true
        }
        if let bubble = CurrentUserData.instance.inflamationsForehead, bubble == true {
            return true
        }
        if let bubble = CurrentUserData.instance.inflamationsAroundNose, bubble == true {
            return true
        }
        
        return false
    }
    
    func checkForThirteen() -> Bool {
        if let smoking = CurrentUserData.instance.habitSmoking, smoking == true {
            return true
        }
        if let coffee = CurrentUserData.instance.habitCoffee, coffee == true {
            return true
        }
        if let sport = CurrentUserData.instance.habitSport, sport == true {
            return true
        }
        if let age = CurrentUserData.instance.age, age >= 25 {
            return true
        }
        if let lyfestyle = CurrentUserData.instance.placeOfLiving {
            if lyfestyle == .mountain || lyfestyle == .sea {
                return true
            }
        }
        return false
    }
    
    @IBAction func logOutBtnWasPressed(_ sender: Any) {
        let logoutPopout = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                clearUserData()
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
