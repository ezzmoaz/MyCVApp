//
//  MyWorkDetailedVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 5/6/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Spring
import Font_Awesome_Swift
import SKPhotoBrowser
import SDWebImage

class MyWorkDetailedVC: TransitionBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    let redView = UIView()
    
    var project = Project()
    var images = [SKPhoto]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appStoreBtn: UIButton!
    @IBOutlet weak var github: UIButton!
    @IBOutlet weak var youtubeOrOther: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var programingLang: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var disclaimerView: UIView!
    @IBOutlet weak var diclaimerImage: UIImageView!
    @IBOutlet weak var disclaimerLbl: UILabel!
    @IBAction func appleStorePressed(_ sender: Any) {
        print("appleStorePressed")
        let urlStr = project.appStore ?? ""
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(URL(string: urlStr)!)
        }
    }
    
    
    
    @IBAction func githubPressed(_ sender: Any) {
        print("githubPressed")
        let urlStr = project.github ?? ""
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(URL(string: urlStr)!)
        }
    }
    @IBAction func youtubeOrOtherPressed(_ sender: Any) {
        print("youtubeOrOtherPressed")
        let urlStr = project.other ?? ""
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(URL(string: urlStr)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.becomeFirstResponder()
        appStoreBtn.setFAIcon(icon: .FAApple, forState: .normal)
        appStoreBtn.setFATitleColor(color: ColorControll.sharedInstance.getMainColor())
        github.setFAIcon(icon: .FAGithub, forState: .normal)
        github.setFATitleColor(color: ColorControll.sharedInstance.getMainColor())
        youtubeOrOther.setFAIcon(icon: .FAYoutube, forState: .normal)
        youtubeOrOther.setFATitleColor(color: ColorControll.sharedInstance.getMainColor())
        
        setupView()
        
        self.view.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: self.view.frame, style: .topToBottom, isReversed: false)
        
        
        for i in project.screens ?? [] {
            let photo = SKPhoto.photoWithImageURL(i, holder: #imageLiteral(resourceName: "boy"))
            images.append(photo)
        }

    }
    
    
    private func setupView(){
        
        let url = URL(string: project.mainImage ?? "")
        imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "boy"), options: .highPriority, completed: nil)
        imageView.hero.id = "batMan2"

        descriptionLbl.text = project.description
        programingLang.text = project.progLang
        duration.text = project.duration
        if project.isAppStore ?? false {
            appStoreBtn.isEnabled = true
            appStoreBtn.alpha = 1.0
        }
        if project.isGithub ?? false {
            github.isEnabled = true
            github.alpha = 1.0
        }
        
        if project.isOther ?? false {
            youtubeOrOther.isEnabled = true
            youtubeOrOther.alpha = 1.0
        }
        
        if project.isDisclaimer ?? false {
            disclaimerView.isHidden = false
            disclaimerLbl.text = project.disclaimerName
            let url = URL(string: project.disclaimerImage ?? "")
            diclaimerImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "boy"), options: .highPriority, completed: nil)
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return project.screens?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenCell", for: indexPath)
        let imageView = cell.viewWithTag(2) as? UIImageView
        let url = URL(string: project.screens?[indexPath.row] ?? "")
        imageView?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "boy"), options: .highPriority, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath)
        let imageView = cell?.viewWithTag(2) as? UIImageView
        let browser = SKPhotoBrowser(originImage: (imageView?.image ?? #imageLiteral(resourceName: "boy")), photos: images, animatedFromView: cell!)
        browser.initializePageIndex(indexPath.row)
        present(browser, animated: true, completion: {})
    }
    
    
   


}
