//
//  ArticleCellTableViewCell.swift
//  В-stone
//
//  Created by Георгий Фесенко on 28.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var articleImg: UIImageView!
    @IBOutlet weak var readMoreOrLessBtn: UIButton!
    
    
    private var preview = ""
    private var body = ""
    private var article = ""
    
    private var indexPath: IndexPath?
    
    private var readMoreOrLess = false
    weak var delegate: CellChangingProtocol?
    

    @IBAction func readMoreBtnTapped(_ sender: UIButton) {
        if readMoreOrLess == false {
            self.txtLbl.text = self.txtLbl.text! + "\n" + body
            delegate?.cellDidChange(article: article, indexPath)
            readMoreOrLess = true
            sender.setTitle("hide", for: .normal)
            
        } else {
            self.txtLbl.text = preview
            delegate?.cellDidChange(article: article, indexPath)
            readMoreOrLess = false
            sender.setTitle("Read more", for: .normal)
        }
        
        
    }
    
    func configureCell(article: Article, fullText: Bool, indexPath: IndexPath) {
        self.indexPath = indexPath
        if fullText {
            headerLbl.text = article.header
            txtLbl.text = article.preview + article.body
            
            self.body = article.body
            self.preview = article.preview
            self.article = article.imageName
            
            self.readMoreOrLess = true
            
            articleImg.image = UIImage(named: article.imageName)
            readMoreOrLessBtn.setTitle("hide", for: .normal)
            
        } else {
            headerLbl.text = article.header
            txtLbl.text = article.preview
            
            self.body = article.body
            self.preview = article.preview
            self.article = article.imageName
            self.readMoreOrLess = false
            
            articleImg.image = UIImage(named: article.imageName)
            readMoreOrLessBtn.setTitle("Read more", for: .normal)
        }
        
    }

}

protocol CellChangingProtocol: class {
    func cellDidChange(article: String, _ indexPath: IndexPath?)
}


