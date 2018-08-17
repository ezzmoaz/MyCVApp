//
//  HelloVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/22/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Hero
import Spring

class HelloVC: UIViewController {
    
//    let redView = UIView()
//    let blackView = UIView()
    @IBOutlet weak var redView: DesignableView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var PhotoView: DesignableView!
    @IBOutlet weak var introImage: SpringImageView!
    @IBOutlet weak var MyNameIsLbl: UILabel!
    
    
    @IBOutlet weak var ViewTohandleTheImageBounds: UIView!
    @IBOutlet weak var myNameLbl: SpringLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: redView.frame, style: .topToBottom, isReversed: false)
        
        MyNameIsLbl.hero.id = "MegaMan"
        redView.hero.id = "ironMan"
//        view.addSubview(redView)
        let url = URL(string: User.sharedInstance.getMainImage() ?? "")
        introImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "boy"), options: .highPriority, completed: nil)
        labelView.hero.id = "batMan"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeColor), name:NSNotification.Name(rawValue: "ChangeColor"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
       
        PhotoView.animation = "swing"
        PhotoView.curve = "easeInOut"
        PhotoView.duration =  1.0
        PhotoView.delay =  0.25
        PhotoView.animate()
    }
    
    
    @objc func onTap() {
        
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "HelloDetailedVC") as! HelloDetailedVC
        vc2.hero.isEnabled = true
        introImage.animate()
        present(vc2, animated: true, completion: nil)
    }
    
    @objc private func changeColor() {
        redView.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: redView.frame, style: .topToBottom, isReversed: false)
    }
}


