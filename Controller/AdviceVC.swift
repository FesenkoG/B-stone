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
    var texts = [String]()
    
    @IBAction func prepareForUnwindHey(segue: UIStoryboardSegue) {
        let vc = segue.destination as! AdviceVC
        vc.tabBarController?.tabBar.isTranslucent = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarItem.selectedImage = UIImage(named: "advice_selected")!.withRenderingMode(.alwaysOriginal)
        let base = "article"
        for number in 1...8 {
            let newBase = base + String(describing: number)
            let filePath = Bundle.main.path(forResource: newBase, ofType: "txt")!
            do {
                let text = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                texts.append(text)
            } catch {
                print(error)
            }
        }
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
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as? ArticleCell else { return UITableViewCell() }
        let sepStr = texts[indexPath.row].components(separatedBy: ";")
        let header = sepStr[0]
        let preview = sepStr[1]
        let body = sepStr[2]
        cell.configureCell(header: header, preview: preview, text: body, imgName: "\(indexPath.row + 1)")
        cell.selectionStyle = .default
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sepStr = texts[indexPath.row].components(separatedBy: ";")
        
        let header = sepStr[0]
        let preview = sepStr[1]
        let body = sepStr[2]
        var article = Article.init(header: header, preview: preview, body: body, imageName: "\(indexPath.row + 1)")
        
        performSegue(withIdentifier: "toArticle", sender: article)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let articleVC = segue.destination as? ArticleVC else { return }
        guard let article = sender as? Article else { return }
        
        articleVC.configureView(header: article.header, preview: article.preview, body: article.body, imgName: article.imageName)
    }
}
