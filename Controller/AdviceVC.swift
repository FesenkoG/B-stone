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
    
    var isReadMore = [String: Bool]()
    
    @IBAction func prepareForUnwindHey(segue: UIStoryboardSegue) {
        let vc = segue.destination as! AdviceVC
        vc.tabBarController?.tabBar.isTranslucent = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 465
        
        self.tabBarItem.selectedImage = UIImage(named: "advice_selected")!.withRenderingMode(.alwaysOriginal)
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
    }
    
    func articlesToShow() -> [Int] {
        //Возвращает набор индексов статей для показа,  основываясь на данных пользователя
        return [1, 2, 3, 4, 5, 6, 7, 8]
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
}

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
            cell.configureCell(article: article, fullText: flag)
            cell.delegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as? ArticleCell else { return UITableViewCell() }
            let article = Article(header: articles[indexPath.row].header, preview: articles[indexPath.row].preview, body: articles[indexPath.row].body, imageName: articles[indexPath.row].imageName)
            cell.configureCell(article: article, fullText: flag)
            cell.delegate = self
            
            return cell
        }
        
    }
    
}

extension AdviceVC: CellChangingProtocol {
    func cellDidChange(article: String) {
        if isReadMore[article] == nil {
            isReadMore[article] = false
        } else if isReadMore[article] == false {
            isReadMore[article] = true
        } else {
            isReadMore[article] = false
        }
        
        tableView.beginUpdates()
        
        tableView.endUpdates()
    }
    
    
}
