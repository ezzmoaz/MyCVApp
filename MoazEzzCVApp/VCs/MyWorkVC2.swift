//
//  ViewController.swift
//  GravitySliderExample
//
//  Created by Artem Tevosyan on 9/27/17.
//  Copyright © 2017 Artem Tevosyan. All rights reserved.
//

import UIKit
import GravitySliderFlowLayout
import SDWebImage

class MyWorkVC2: UIViewController {
    
    
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
        
        print("height : \(collectionView.frame.size.height )")
        print("width : \(collectionView.frame.size.width )")
        let gravitySliderLayout = GravitySliderFlowLayout(with: CGSize(width: collectionView.frame.size.height , height: collectionView.frame.size.height ))
        gravitySliderLayout.minimumLineSpacing = 1
        
        collectionView.collectionViewLayout = gravitySliderLayout
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
        let cellArray = collectionView.visibleCells as! [WorkCell]
        for i in cellArray {
            configureWorkCellJustView(i)
        }

    }
    
    
    
}

extension MyWorkVC2: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

extension MyWorkVC2: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationFirst = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationSecond = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x + 20, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationThird = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x - 20, y: collectionView.center.y + scrollView.contentOffset.y)
        
        if let indexPathFirst = collectionView.indexPathForItem(at: locationFirst), let indexPathSecond = collectionView.indexPathForItem(at: locationSecond), let indexPathThird = collectionView.indexPathForItem(at: locationThird), indexPathFirst.row == indexPathSecond.row && indexPathSecond.row == indexPathThird.row && indexPathFirst.row != pageControl.currentPage {
            print(projects.count)
            pageControl.currentPage = indexPathFirst.row % projects.count
//            self.animateChangingTitle(for: indexPathFirst)
        }
    }
}


