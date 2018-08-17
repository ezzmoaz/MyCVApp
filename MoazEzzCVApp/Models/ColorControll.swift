//
//  ColorControll.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 5/6/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import Foundation
import ChameleonFramework

//    MainColor = UIColor(hex: "ff8181")
//    MainDarkColor =  UIColor(hex: "a81382")



class ColorControll {
    static let sharedInstance = ColorControll()
    private init() {}
    
    private var MainColor = UIColor(hex: "ff8181")
    private var MainDarkColor =  UIColor(hex: "a81382")
    private var MainGray = UIColor(hex: "7F8C8D")

    
    
    enum selectGradient {
        case red
        case yellow
        case blue
    }
    
    func setMainColor(color:selectGradient){
        switch color {
        case .red:
            MainColor = UIColor(hex: "e52d27")
            MainDarkColor =  UIColor(hex: "b31217")
            saveTheme(color: color.hashValue)
        case .yellow:
            MainColor = UIColor(hex: "FFC837")
            MainDarkColor =  UIColor(hex: "FF8008")
            saveTheme(color: color.hashValue)
        case .blue :
            MainColor = UIColor(hex: "1488CC")
            MainDarkColor =  UIColor(hex: "2B32B2")
            saveTheme(color: color.hashValue)
        }
        
    }
    
    func getMainColor() -> UIColor {
        return MainColor
    }
    
    func getMainDarkColor() -> UIColor {
        return MainDarkColor
    }
    
    func getMainGray() -> UIColor {
        return MainGray
    }
    
    func getNormalFont(size: CGFloat) -> UIFont? {
        let temp = UIFont(name: "Cairo", size: size)
        return temp
    }
    
    func getBoldFont(size: CGFloat) -> UIFont? {
        let temp = UIFont(name: "Cairo-Bold", size: size)
        return temp
    }
    
    func getGradiantColor(frame : CGRect, style : UIGradientStyle, isReversed : Bool) -> UIColor{
        if isReversed{
            return UIColor.init(gradientStyle: style, withFrame: frame, andColors: [MainDarkColor, MainColor])
        }else{
            return UIColor.init(gradientStyle: style, withFrame: frame, andColors: [MainColor, MainDarkColor])
        }
    }
    
    private func saveTheme(color:Int){
        UserDefaults.standard.set(color, forKey: "ThemeColor")
    }
    func fetchTheme(){
        if let temp = UserDefaults.standard.object(forKey: "ThemeColor" ) as? Int{
            
            switch temp {
            case 1:
                setMainColor(color: .yellow)
            case 2 :
                setMainColor(color: .blue)
            default:
                setMainColor(color: .red)
            }
        }else{
            setMainColor(color: .red)
        }
    }
    


}




