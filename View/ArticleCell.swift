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
    

    
    func configureCell(header: String, preview: String, text: String, imgName: String) {
        
        headerLbl.text = header
        txtLbl.text = preview
        articleImg.image = UIImage(named: imgName)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }


}
