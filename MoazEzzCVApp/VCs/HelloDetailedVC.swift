//
//  HelloDetailedVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/24/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Hero
import Spring
import TableFlip

class HelloDetailedVC: TransitionBaseViewController, UITableViewDataSource, UITableViewDelegate {

    

    let whiteView = UIView()
    
    var myExperience = [ExperienceSection]()

    var headerView = UIView()
    var blackView = DesignableView()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.hero.id = "ironMan"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.isScrollEnabled = true
        myExperience = User.sharedInstance.getExperiences()
        self.view.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: self.view.frame, style: .topToBottom, isReversed: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
        setupHeaderView()
        setupTableView()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.frame = view.bounds
        
        blackView.frame.size = CGSize(width: 250, height: 60)
        blackView.center = CGPoint(x: self.view.bounds.midX - 20 , y: 50)
//        whiteView.frame = CGRect(x: (view.bounds.width) / 10, y: 180, width: ((view.bounds.width) / 10) * 8, height:  CGFloat(myExperience.count * 128 + 40))
        
        
    }
    
    @objc private func handleTap(_:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setupHeaderView(){
        
        
        blackView.backgroundColor = ColorControll.sharedInstance.getMainGray()
        blackView.hero.id = "batMan"
        blackView.layer.cornerRadius = 8
        print(self.view.frame.width)
        print(self.view.frame.height)
        blackView.frame = CGRect(x: (self.view.frame.width/2), y: 50, width: 50, height: 20)
        blackView.layer.masksToBounds = false
        blackView.layer.shadowOpacity = 0.5
        blackView.layer.shadowOffset = CGSize(width: 0.4, height: 0.5)
        blackView.layer.shadowRadius = 5
        headerView.addSubview(blackView)
        headerView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 100.0)
        headerView.backgroundColor = UIColor.clear
        
        let lbl = UILabel()
        lbl.font = ColorControll.sharedInstance.getBoldFont(size: 20)
        lbl.textColor = UIColor.white
        lbl.frame.size = CGSize(width: 250, height: 60)
        blackView.addSubview(lbl)
        lbl.center = CGPoint(x: 125  , y: 30)
        lbl.text = "About Me"
        lbl.textAlignment = .center
        
    }
    
    private func setupTableView(){
        
        
        TableViewAnimation.Cell.left(duration: 0.5)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = headerView
        tableView.frame = CGRect(x: 25.0, y: 0.0, width: self.view.frame.width - 50.0, height: self.view.frame.height )
        self.view.addSubview(tableView)
        self.tableView.reloadData()
        let degrees = sin(90.0 * CGFloat.pi/180.0)
        let rotationTransform = CGAffineTransform(rotationAngle: degrees)
        let flipTransform = CGAffineTransform(scaleX: -1, y: -1)
        let customTransform = rotationTransform.concatenating(flipTransform)
        
        let customAnimation = TableViewAnimation.Cell.custom(duration: 0.6, transform: customTransform, options: .curveEaseInOut)
        
        self.tableView.animate(animation: customAnimation, completion: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        self.tableView.animate(animation: TableViewAnimation.Cell.fade(duration: 0.5), completion: nil)
//        self.tableViewanimate(animation: TableViewAnimation.Cell.right(duration: 0.5), completion: nil)

    }
    

    //TableView setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myExperience.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:40))
        backView.backgroundColor = UIColor.clear;
        
        let label = UILabel()
        
        
        label.font = ColorControll.sharedInstance.getBoldFont(size: 20)
        label.text = myExperience[section].sectionName
        label.textAlignment = .center
        label.textColor = ColorControll.sharedInstance.getMainDarkColor()
//        (tableView.frame.size.width / 2) - ((label.intrinsicContentSize.width + 40)/2)
        let centerView = UIView(frame: CGRect(x:15, y:0, width:label.intrinsicContentSize.width + 40, height:40))
        label.frame = CGRect(x:0, y:0, width:centerView.frame.size.width, height:40)
        centerView.backgroundColor = .white
        centerView.addSubview(label);
        backView.addSubview(centerView);
        centerView.layer.masksToBounds = false;
        centerView.layer.cornerRadius = 25
        centerView.layer.shadowRadius = 5;
        centerView.layer.shadowOpacity = 0.5;
        centerView.layer.cornerRadius = 10;
        
        return backView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myExperience[section].experiences?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ExperienceCell", owner: self, options: nil)?.first as! ExperienceCell
        
        cell.expTitle.text = myExperience[indexPath.section].experiences?[indexPath.row].name ?? ""
        cell.expDate.text = myExperience[indexPath.section].experiences?[indexPath.row].date ?? ""
        cell.icon.image = UIImage(named: myExperience[indexPath.section].experiences?[indexPath.row].icon ?? "boy")
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }

}
