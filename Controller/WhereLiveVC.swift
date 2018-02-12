//
//  WhereLiveVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 01.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class WhereLiveVC: UIViewController {
    
    
    
    @IBOutlet weak var countrysideImg: UIImageView!
    @IBOutlet weak var seaImg: UIImageView!
    @IBOutlet weak var mountainImg: UIImageView!
    @IBOutlet weak var megalopolisImg: UIImageView!
    
    var placeOfLiving: PlaceOfLiving?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func countrysideBtnWasPressed(_ sender: Any) {
        setImage(place: .countryside)
    }
    
    @IBAction func mountainBtnWasPressed(_ sender: Any) {
        setImage(place: .mountain)
    }
    
    @IBAction func seaBtnWasPressed(_ sender: Any) {
        setImage(place: .sea)
    }
    @IBAction func megalopolisBtnWasPressed(_ sender: Any) {
        setImage(place: .megapolis)
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        if let place = placeOfLiving {
            CurrentUserData.instance.placeOfLiving = place
            guard let lifestyleVC = storyboard?.instantiateViewController(withIdentifier: "LifestyleVC") as? LifestyleVC else { return }
            presentDetail(lifestyleVC)
        }
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
    func setImage(place: PlaceOfLiving) {
        
        countrysideImg.image = UIImage(named: "countryside")
        mountainImg.image = UIImage(named: "mountain")
        seaImg.image = UIImage(named: "sea")
        megalopolisImg.image = UIImage(named: "megalopolis")
        
        placeOfLiving = place
        
        switch place {
        case .countryside:
            countrysideImg.image = UIImage(named: "countrysideSelected")
        case .mountain:
            mountainImg.image = UIImage(named: "mountainSelected")
        case .megapolis:
            megalopolisImg.image = UIImage(named: "megalopolisSelected")
        case .sea:
            seaImg.image = UIImage(named: "seaSelected")
        }
        

    }

}
