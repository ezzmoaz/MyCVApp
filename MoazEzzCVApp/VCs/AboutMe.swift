//
//  ContactMeVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/22/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit

class AboutMe: UIViewController {
    
    @IBOutlet weak var experiance: UILabel!
    @IBOutlet weak var IOS_MacOs: UILabel!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var Years: UILabel!
    
    
    
    var width1 = CGFloat()
    var width2 = CGFloat()
    var width3 = CGFloat()
    var width4 = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About Me"
        IOS_MacOs.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: IOS_MacOs.bounds, style: .leftToRight, isReversed: true)
        experiance.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: experiance.bounds, style: .leftToRight, isReversed: true)
        developer.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: developer.bounds, style: .leftToRight, isReversed: true)
        Years.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: Years.bounds, style: .leftToRight, isReversed: true)
        
        width1 = IOS_MacOs.frame.width
        width2 = experiance.frame.width
        width3 = developer.frame.width
        width4 = Years.frame.width
        
        reset(label: IOS_MacOs)
        reset(label: experiance)
        reset(label: developer)
        reset(label: Years)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setuoBtns), name:NSNotification.Name(rawValue: "ChangeColor"), object: nil)
        

    }
    

    
    override func viewDidDisappear(_ animated: Bool) {
        reset(label: IOS_MacOs)
        reset(label: experiance)
        reset(label: developer)
        reset(label: Years)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        animateViewFor(duration: 0.7, label: IOS_MacOs, width: width1)
        animateViewFor(duration: 0.7, label: experiance, width: width2)
        animateViewFor(duration: 0.5, label: developer, width: width3)
        animateViewFor(duration: 0.5, label: Years, width: width4)
        
    }
    
    private func animateViewFor(duration : Double, label : UILabel, width : CGFloat){
        let x = label.frame.origin.x
        let y = label.frame.origin.y
//        let width = label.frame.width
        let height = label.frame.height
        label.frame = CGRect(x: x, y: y, width: 0, height: height)
        UIView.animate(withDuration: duration) {
            label.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    private func reset(label : UILabel){
        let x = label.frame.origin.x
        let y = label.frame.origin.y
        let height = label.frame.height
        label.frame = CGRect(x: x, y: y, width: 0, height: height)
    }
    
    @objc private func setuoBtns(){
        
        IOS_MacOs.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: CGRect(x: IOS_MacOs.frame.origin.x, y: IOS_MacOs.frame.origin.y, width: width1, height: IOS_MacOs.frame.height), style: .leftToRight, isReversed: true)
        experiance.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame:  CGRect(x: experiance.frame.origin.x, y: experiance.frame.origin.y, width: width2, height: experiance.frame.height), style: .leftToRight, isReversed: true)
        developer.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: CGRect(x: developer.frame.origin.x, y: developer.frame.origin.y, width: width3, height: developer.frame.height), style: .leftToRight, isReversed: true)
        Years.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: CGRect(x: Years.frame.origin.x, y: Years.frame.origin.y, width: width4, height: Years.frame.height), style: .leftToRight, isReversed: true)
    }
    

}




