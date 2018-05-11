//
//  ArticleWithoutImageCell.swift
//  В-stone
//
//  Created by Георгий Фесенко on 02.05.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class ArticleWithoutImageCell: UITableViewCell {
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    private var preview = ""
    private var body = ""
    private var article = ""
    
    private var indexPath: IndexPath?
    
    private var readMoreOrLess = false
    weak var delegate: CellChangingProtocol?
    
    @IBAction func readMoreBtnWasTapped(_ sender: UIButton) {
        if readMoreOrLess == false {
            self.textLbl.text = preview + "\n" + body
            
            delegate?.cellDidChange(article: article, indexPath)
            readMoreOrLess = true
            sender.setTitle("hide", for: .normal)
            
        } else {
            self.textLbl.text = preview
            
            delegate?.cellDidChange(article: article, indexPath)
            readMoreOrLess = false
            sender.setTitle("Read more", for: .normal)
        }
    }
    
    func configureCell(article: Article, fullText: Bool, indexPath: IndexPath) {
        self.indexPath = indexPath
        if fullText {
            headerLbl.text = article.header
            textLbl.text = article.preview + article.body
            
            self.body = article.body
            self.preview = article.preview
            self.article = article.imageName
            
            self.readMoreOrLess = true
            
            readMoreBtn.setTitle("hide", for: .normal)
            
        } else {
            headerLbl.text = article.header
            textLbl.text = article.preview
            
            self.body = article.body
            self.preview = article.preview
            self.article = article.imageName
            self.readMoreOrLess = false
            
            readMoreBtn.setTitle("Read more", for: .normal)
        }
    }
    

}
