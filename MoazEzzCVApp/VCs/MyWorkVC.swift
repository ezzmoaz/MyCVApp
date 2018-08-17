//
//  MyWorkVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/22/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
//MyWorkCell





class MyWorkVC: UIViewController {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let projects = User.sharedInstance.getProjects()
    
    
    
    let cellsShadowColor = UIColor(hex: "2a002a").cgColor
    let productCellIdentifier = "WorkCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPageIndicatorTintColor = ColorControll.sharedInstance.getGradiantColor(frame: pageControl.bounds, style: .topToBottom, isReversed: true)
        configureCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeColor), name:NSNotification.Name(rawValue: "ChangeColor"), object: nil)
        
    }
    
    
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func configureWorkCell(_ cell: WorkCell, for indexPath: IndexPath) {
        cell.clipsToBounds = false
        
        cell.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: cell.bounds, style: .topToBottom, isReversed: false)
        cell.layer.shadowColor = cellsShadowColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 30)
        
        cell.layer.cornerRadius = 21
        let url = URL(string: projects[indexPath.row].mainImage ?? "")
        cell.productImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "boy"), options: .highPriority, completed: nil)
        
        cell.newLabel.layer.cornerRadius = 8
        cell.newLabel.clipsToBounds = true
        cell.newLabel.layer.borderColor = UIColor.white.cgColor
        cell.newLabel.layer.borderWidth = 1.0
        if !(projects[indexPath.row].isNew ?? false) {
            cell.newLabel.isHidden = true
        }
        cell.nameLbl.text = projects[indexPath.row].name
        
    }
    
    private func configureWorkCellJustView(_ cell: WorkCell) {
        cell.clipsToBounds = false
        cell.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: cell.bounds, style: .topToBottom, isReversed: false)
        cell.layer.shadowColor = cellsShadowColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 30)
        
        cell.layer.cornerRadius = 21
        
        
        
        cell.newLabel.layer.cornerRadius = 8
        cell.newLabel.clipsToBounds = true
        cell.newLabel.layer.borderColor = UIColor.white.cgColor
        cell.newLabel.layer.borderWidth = 1.0
    }
    
    @objc private func changeColor() {
        pageControl.currentPageIndicatorTintColor = ColorControll.sharedInstance.getGradiantColor(frame: pageControl.bounds, style: .topToBottom, isReversed: true)
        collectionView.reloadData()
    }
}

extension MyWorkVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = projects.count
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIdentifier, for: indexPath) as! WorkCell
        self.configureWorkCell(cell, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: Hero configuration
        
        // here we are using the data as the hero.id, we have to make sure that this id is
        // unique for each cell. a random hero.id will also work.
        let heroId = "cell\(indexPath.row)"
        let cell = collectionView.cellForItem(at: indexPath) as? WorkCell
        cell?.hero.id = heroId
        cell?.productImage.hero.id = "batMan2"
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyWorkDetailedVC") as! MyWorkDetailedVC
        vc.hero.isEnabled = true
        
        vc.project = projects[indexPath.row]
        // copy over the backgroundColor and hero.id over to the next view
        // controller. In a real app, we would be passing some data correspoding to the cell
        // being tapped. then configure the next view controller according to the data.
        // and make sure that views that need to be transitioned have the same hero.id
        
        
        vc.view.hero.id = heroId
        
        present(vc, animated: true, completion: nil)
    }
    
    
}

extension MyWorkVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("width: \(self.view.frame.width)")
        print("height: \(self.view.frame.height)")
        return CGSize(width: view.frame.height - 50, height: view.frame.width - 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print("width: \(self.view.frame.width)")
        print("height: \(self.view.frame.height)")
        let cellWidth : CGFloat = self.view.frame.width - 50
        
        let numberOfCells = floor(self.view.frame.size.width / cellWidth)
        let edgeInsets = (self.view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsetsMake(15, edgeInsets, 0, edgeInsets)
    }
    
    
    
    
}

extension MyWorkVC: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
}


