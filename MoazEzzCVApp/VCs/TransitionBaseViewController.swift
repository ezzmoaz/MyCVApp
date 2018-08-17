//
//  TransitionBaseViewController.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/24/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class TransitionBaseViewController: UIViewController {
    let dismissButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onTap)))
        
        
        dismissButton.setFAIcon(icon: .FAArrowLeft, iconSize: 20, forState: .normal)
        dismissButton.tintColor = ColorControll.sharedInstance.getMainDarkColor()
        dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        dismissButton.hero.id = "back button"
        view.addSubview(dismissButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dismissButton.sizeToFit()
        dismissButton.center = CGPoint(x: 30, y: 30)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onTap() {
        back() // default action is back on tap
    }
}
