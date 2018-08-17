//
//  LoadingVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/26/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Hero

class LoadingVC: UIViewController {
    
    
    @IBOutlet weak var AnimatedView: UIImageView!
    @IBOutlet weak var Lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ColorControll.sharedInstance.fetchTheme()
        fetchData()
        
        
        let MainGif = UIImage.gifImageWithName("AnimatedGif")
        AnimatedView.image = MainGif
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        view.hero.id = "MegaMan"
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.Lbl.text = "Preparing..."
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.Lbl.text = "Press Me"
        }
    }

    @objc func onTap() {
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        vc2.hero.isEnabled = true
        present(vc2, animated: true, completion: nil)
    }
    
    
    private func fetchData(){
    
        let flag = getData() // true = new data, false = get saved data
        
        switch flag {
        case true:
            //do not do anything the new data is alredy in User.sharedInstant
            //save the new date flag
//            User.sharedInstance.saveUser(jsonData: nil)
//            User.sharedInstance.fetchUser()
            break
        case false:
            User.sharedInstance.fetchUser()
        }
        
    
    }
    
    private func getData() -> Bool{
        print("TODO -> Getting the data from fireBase")
        //here we should first handle the data flag that will come from the server if the date do not match we should send request to get new data and return true
        return false
    }
    
}
