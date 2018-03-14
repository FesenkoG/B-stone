//
//  ArticleVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 02.03.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class ArticleVC: UIViewController {

    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var previewLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var imageLbl: UIImageView!
    
    var header = ""
    var preview = ""
    var body = ""
    var imgName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLbl.text = header
        previewLbl.text = preview
        bodyLbl.text = body
        imageLbl.image = UIImage(named: imgName)
        
        var swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        self.dismissDetail()
    }
    func configureView(header: String, preview: String, body: String, imgName: String) {
        
        self.header = header
        self.preview = preview
        self.body = body
        self.imgName = imgName
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
}
