//
//  ViewController.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/22/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Parchment
import FanMenu
import Macaw

class MainVC: UIViewController {
    let colors = [0xe52d27, 0xFFC837, 0x1488CC]
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var fanMenu: FanMenu!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorBtn()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.view.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: self.view.frame, style: .topToBottom, isReversed: false)
        MainView.backgroundColor = UIColor.clear
        let firstViewController = storyboard?.instantiateViewController(withIdentifier: "HelloVC") as! HelloVC
        let secondViewController = storyboard?.instantiateViewController(withIdentifier: "AboutMe") as! AboutMe

        let thirdViewController = storyboard?.instantiateViewController(withIdentifier: "MyWorkVC") as! MyWorkVC
        
        var forthViewController = storyboard?.instantiateViewController(withIdentifier: "ContactMeVC") as! ContactMeVC
        
        
        // Initialize a FixedPagingViewController and pass
        // in the view controllers.
        firstViewController.title = "Hello"
        secondViewController.title = "ContactMe"
        thirdViewController.title = "My Work"
        forthViewController.title = "Contact Me"
        
        
        //to retate the UIView
        firstViewController.view.transform = CGAffineTransform(rotationAngle: 90 * ((22/7)/180))
        secondViewController.view.transform = CGAffineTransform(rotationAngle: 90 * ((22/7)/180))
        thirdViewController.view.transform = CGAffineTransform(rotationAngle: 90 * ((22/7)/180))
        forthViewController.view.transform = CGAffineTransform(rotationAngle: 90 * ((22/7)/180))
        let pagingViewController = FixedPagingViewController(viewControllers: [
            firstViewController,
            secondViewController,
            thirdViewController,
            forthViewController
            ])
        
        pagingViewController.indicatorOptions = .hidden
        pagingViewController.textColor = UIColor.lightGray
        pagingViewController.selectedTextColor = UIColor.white
        pagingViewController.menuBackgroundColor = UIColor.clear
        pagingViewController.font = ColorControll.sharedInstance.getNormalFont(size: 17)!
        pagingViewController.selectedFont = ColorControll.sharedInstance.getBoldFont(size: 17)!
        
        pagingViewController.borderOptions = .hidden
//        self.setupColorBtn()
        print(modelIdentifier())
            print(modelIdentifier())
            switch modelIdentifier() {
            case "iPhone10,3":
            pagingViewController.menuItemSize = PagingMenuItemSize.fixed(width: 150, height: 70)
            case "iPhone10,6":
            pagingViewController.menuItemSize = PagingMenuItemSize.fixed(width: 150, height: 70)
            default:
            pagingViewController.menuItemSize = PagingMenuItemSize.fixed(width: 100, height: 30)
            print(modelIdentifier())
            }

        pagingViewController.selectedScrollPosition = .center
        pagingViewController.menuInteraction = .swipe
        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChildViewController(pagingViewController)
        MainView.addSubview(pagingViewController.view)
        
        setupMainView()
        
        pagingViewController.didMove(toParentViewController: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: MainView.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: MainView.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: MainView.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: MainView.topAnchor )
            ])
        
       

    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: self.view.frame, style: .topToBottom, isReversed: false)
    }

    
    private func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

    private func setupMainView(){
        MainView.transform = CGAffineTransform(rotationAngle: -90 * ((22/7)/180))
        let heightSaved = MainView.frame.height
        let widthSaved = MainView.frame.width
//        let widthSaved = MainView.frame.width
        MainView.frame = CGRect(x: 10, y: 0, width: heightSaved, height: widthSaved)
    }
   
    private func setupColorBtn(){
        fanMenu.button = mainButton(colorHex: 0xb31217)
//        print(ColorControll.sharedInstance.getMainColor().hexValue())
//        if let colorTemp = Int(ColorControll.sharedInstance.getMainColor().hexValue()){
//            fanMenu.button = mainButton(colorHex: colorTemp)
//        }
        
        fanMenu.items = colors.enumerated().map { (index, item) in
            FanMenuButton(
                id: String(index),
                image: "",
                color: Color(val: item)
            )
        }
        
        fanMenu.menuRadius = 70.0
        fanMenu.duration = 0.2
        fanMenu.interval = (11, 2 * 11)
        fanMenu.radius = 15.0
        
        fanMenu.onItemWillClick = { button in
            if button.id != "main" {
                let newColor = self.colors[Int(button.id)!]
                let fanGroup = self.fanMenu.node as? Group
                let circleGroup = fanGroup?.contents[2] as? Group
                let shape = circleGroup?.contents[0] as? Shape
                shape?.fill = Color(val: newColor)
                self.changeColor(index: Int(button.id)!)
            }
        }
        
        fanMenu.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi/2.0))
    }
    
    private func changeColor(index : Int)  {
        switch index {
        case 0:
            ColorControll.sharedInstance.setMainColor(color: .red)
            changeAppIconRed()
        case 1:
            ColorControll.sharedInstance.setMainColor(color: .yellow)
            changeAppIconYellow()
        case 2:
            ColorControll.sharedInstance.setMainColor(color: .blue)
            changeAppIconBlue()
        default:
            print("Something went wrong!")
        }
        self.view.backgroundColor = ColorControll.sharedInstance.getGradiantColor(frame: self.view.frame, style: .topToBottom, isReversed: false)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeColor"), object: nil)
        
        
    }
    
    private func changeAppIconYellow(){
        if UIApplication.shared.supportsAlternateIcons {
            UIApplication.shared.setAlternateIconName("AlternateIconYellow"){ error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Done!")
                }
            }
        }
    }
    
    private func changeAppIconBlue(){
        if UIApplication.shared.supportsAlternateIcons {
            UIApplication.shared.setAlternateIconName("AlternateIconBlue"){ error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Done!")
                }
            }
        }
    }
    
    private func changeAppIconRed(){
        if UIApplication.shared.supportsAlternateIcons {
            UIApplication.shared.setAlternateIconName(nil)
        }
    }

    
    private func mainButton(colorHex: Int) -> FanMenuButton {
        return FanMenuButton(
            id: "main",
            image: "",
            color: Color(val: colorHex)
        )
    }

}




