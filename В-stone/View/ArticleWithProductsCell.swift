//
//  ArticleWithProductsCell.swift
//  В-stone
//
//  Created by Георгий Фесенко on 01.05.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class ArticleWithProductsCell: UITableViewCell {
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    //Images
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    
    //Labels
    @IBOutlet weak var imageOneLbl: UILabel!
    @IBOutlet weak var imageTwoLbl: UILabel!
    @IBOutlet weak var imageThreeLbl: UILabel!
    
    private var preview = ""
    private var body = ""
    private var article = ""
    
    private var firstItem = ""
    private var secondItem = ""
    private var thirdItem = ""
    
    
    private var readMoreOrLess = false
    weak var delegate: CellChangingProtocol?
    

    @IBAction func readMoreBtnWasTapped(_ sender: UIButton) {
        if readMoreOrLess == false {
            self.textLbl.text = preview + "\n" + body
            
            imageOneLbl.text = firstItem
            imageTwoLbl.text = secondItem
            imageThreeLbl.text = thirdItem
            
            delegate?.cellDidChange(article: article)
            readMoreOrLess = true
            sender.setTitle("hide", for: .normal)
            
        } else {
            self.textLbl.text = preview
            imageOneLbl.text = ""
            imageTwoLbl.text = ""
            imageThreeLbl.text = ""
            delegate?.cellDidChange(article: article)
            readMoreOrLess = false
            sender.setTitle("Read more", for: .normal)
        }
    }
    
    func configureCell(article: Article, fullText: Bool) {
        
        let base = "for"
        let newBase = base + article.imageName
        let filePath = Bundle.main.path(forResource: newBase, ofType: "txt")!
        do {
            let text = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            let sepStr = text.components(separatedBy: "\n")
            let firstHead = sepStr[0]
            let firstDescr = sepStr[1]
            let secondHead = sepStr[2]
            let secondDescr = sepStr[3]
            let thirdHead = sepStr[4]
            let thirdDescr = sepStr[5]
            
            firstItem = firstHead + "\n" + firstDescr
            secondItem = secondHead + "\n" + secondDescr
            thirdItem = thirdHead + "\n" + thirdDescr
        } catch {
            print(error)
        }
        
        
        if fullText {
            
            readMoreBtn.setTitle("hide", for: .normal)
            headerLbl.text = article.header
            textLbl.text = article.preview + article.body
            
            self.preview = article.preview
            self.body = article.body
            self.article = article.imageName
            self.readMoreOrLess = true
            
            imageOne.image = UIImage(named: article.imageName + ".1")
            imageTwo.image = UIImage(named: article.imageName + ".2")
            imageThree.image = UIImage(named: article.imageName + ".3")
            
            //Set up the labels
            imageOneLbl.text = firstItem
            imageTwoLbl.text = secondItem
            imageThreeLbl.text = thirdItem
            
        } else {
            
            readMoreBtn.setTitle("Read more", for: .normal)
            headerLbl.text = article.header
            textLbl.text = article.preview
            
            self.preview = article.preview
            self.body = article.body
            self.article = article.imageName
            self.readMoreOrLess = false
            
            imageOneLbl.text = ""
            imageTwoLbl.text = ""
            imageThreeLbl.text = ""
            
            imageOne.image = UIImage(named: article.imageName + ".1")
            imageTwo.image = UIImage(named: article.imageName + ".2")
            imageThree.image = UIImage(named: article.imageName + ".3")
            
            
        }
    }
    

}
