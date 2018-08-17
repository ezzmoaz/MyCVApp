//
//  ContactMeVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 5/6/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class ContactMeVC: UIViewController {
    
    
    
    @IBOutlet weak var getInTouchLbl: UILabel!
    
    
    @IBOutlet weak var faceBook: UIButton!
    
    @IBOutlet weak var instagram: UIButton!
    
    @IBOutlet weak var email: UIButton!
    
    @IBOutlet weak var linkedIn: UIButton!
    
    @IBOutlet weak var phone: UIButton!
    
    
    @IBAction func faceBookPressed(_ sender: Any) {
        print("https://www.facebook.com/\(User.sharedInstance.getFacebook())")
        
        let Username =  "\(User.sharedInstance.getFacebook())" // Your Instagram Username here
        let appURL = URL(string: "fb://profile/\(Username)")!
        let webURL = URL(string: "https://facebook.com/\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
    @IBAction func instagramPressed(_ sender: Any) {
        print("https://www.instagram.com/\(User.sharedInstance.getInstgram())")
        let Username =  "\(User.sharedInstance.getInstgram())" // Your Instagram Username here
        let appURL = NSURL(string: "instagram://user?username=\(Username)")!
        let webURL = NSURL(string: "https://instagram.com/\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
    @IBAction func emailPressed(_ sender: Any) {
        print(User.sharedInstance.getEmail())
        let email = User.sharedInstance.getEmail()
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func linkedInPressed(_ sender: Any) {
        print("www.linkedin.com/in/\(User.sharedInstance.getLinkedIn())")
        let Username =  "\(User.sharedInstance.getLinkedIn())" // Your Instagram Username here
//        let appURL = NSURL(string: "linkedin://profile?id=\(Username)")!
        let webURL = URL(string: "https://www.linkedin.com/in/\(Username)/")!
        let application = UIApplication.shared
        application.open(webURL as URL)
//        if application.canOpenURL(appURL as URL) {
//            application.open(webURL as URL)
//        } else {
//            // if Instagram app is not installed, open URL inside Safari
//            application.open(webURL as URL)
//        }
        
    }
    
    @IBAction func phonePressed(_ sender: Any) {
        print("ahmed\(User.sharedInstance.getPhone())")
        let temp = User.sharedInstance.getPhone()
        guard let number = URL(string: "tel://" + temp) else { return }
        UIApplication.shared.open(number)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtn(btn: faceBook, text: "  \(User.sharedInstance.getFacebook())", icon: .FAFacebookSquare, size: 20)
        setupBtn(btn: instagram, text: "  \(User.sharedInstance.getInstgram())", icon: .FAInstagram, size: 20)
        setupBtn(btn: email, text: "  \(User.sharedInstance.getEmail())", icon: .FAAt, size: 20)
        setupBtn(btn: linkedIn, text: "  \(User.sharedInstance.getLinkedIn())", icon: .FALinkedinSquare, size: 20)
        setupBtn(btn: phone, text: "  \(User.sharedInstance.getPhone())", icon: .FAPhoneSquare, size: 20)
        getInTouchLbl.backgroundColor = .white
        getInTouchLbl.textColor = ColorControll.sharedInstance.getGradiantColor(frame: getInTouchLbl.frame, style: .leftToRight, isReversed: false)
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeColor), name:NSNotification.Name(rawValue: "ChangeColor"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    private func setupBtn(btn: UIButton, text: String, icon : FAType,size: CGFloat){
        btn.setFAText(prefixText: "", icon: icon, postfixText: text, size: size, forState: .normal, iconSize: size)
        btn.setFATitleColor(color: .white)
        
        }
    @objc private func changeColor(){
        getInTouchLbl.textColor = ColorControll.sharedInstance.getGradiantColor(frame: getInTouchLbl.frame, style: .leftToRight, isReversed: false)
    }

  

}
