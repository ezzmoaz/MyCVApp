//
//  User.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 5/6/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import Foundation

final class User: Decodable {
    //https://www.facebook.com/
    //https://www.instagram.com///
    //www.linkedin.com/in/
    
    static var sharedInstance = User()
    private init() {} //This prevents others from using the default '()' initializer
    
    private var mainImage = ""
    private var faceBook = "Moazezz"
    private var instgram = "ezzmoaz"
    private var email = "moazezz@icloud.com"
    private var linkedIn = "moaz-belal"
    private var phone = "+201001726267"
    private var experiances = [ExperienceSection]()
    private var projects = [Project]()
    
    
    func getMainImage() -> String {
        return mainImage
    }
    
    func getFacebook() -> String {
        return faceBook
    }
    
    func getInstgram() -> String {
        return instgram
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getLinkedIn() -> String {
        return linkedIn
    }
    
    func getPhone() -> String {
        return phone
    }
    
    func getExperiences() -> [ExperienceSection] {
        return experiances
    }

    
    func getProjects() -> [Project] {
        return projects
    }
    
    func loadData() {
        
        let temp = "{\"mainImage\":\"Moazezz\",\"faceBook\":\"Moazezz\",\"instgram\":\"ezzmoaz\",\"email\":\"moazezz@icloud.com\",\"linkedIn\":\"moaz-belal\",\"phone\":\"+201001726267\",\"experiances\":[{\"sectionName\":\"first\",\"experiences\":[{\"icon\":\"boy\",\"name\":\"Moaz\",\"date\":\"2018-7-3\"},{\"icon\":\"boy\",\"name\":\"Moaz2\",\"date\":\"2018-7-4\"}]}],\"projects\":[{\"mainImage\":\"Moaz\",\"name\":\"Moaz\",\"description\":\"Bachelor Computer and Communications Engineering , Faculty of Engineering, Alexandria University.\",\"duration\":\"2018-7-3\",\"progLang\":\"2018-7-3\",\"screens\":[\"2018-7-3\"],\"appStore\":\"2018-7-3\",\"github\":\"2018-7-3\",\"other\":\"2018-7-3\",\"disclaimerName\":\"2018-7-3\",\"disclaimerImage\":\"2018-7-3\",\"isDisclaimer\":true,\"isAppStore\":true,\"isGithub\":true,\"isOther\":true,\"isNew\":true},{\"mainImage\":\"Moaz2\",\"name\":\"Moa2z\",\"description\":\"Bachelor Computer and Communications Engineering , Faculty of Engineering, Alexandria University.\",\"duration\":\"2018-7-3\",\"progLang\":\"2018-7-3\",\"screens\":[\"2018-7-3\"],\"appStore\":\"2018-7-3\",\"github\":\"2018-7-3\",\"other\":\"2018-7-3\",\"disclaimerName\":\"2018-7-3\",\"disclaimerImage\":\"2018-7-3\",\"isDisclaimer\":false,\"isAppStore\":false,\"isGithub\":false,\"isOther\":false,\"isNew\":false}]}".data(using: .utf8)
        
        saveUser(jsonData: temp!)
        fetchUser()
    }
    
    
    func saveUser(jsonData : Data) {
        UserDefaults.standard.set(jsonData, forKey: "SavedUser")
    }
    
    
    func remove() {
        UserDefaults.standard.removeObject(forKey: "SavedUser")
    }
    
    func fetchUser(){
        if let savedValue = UserDefaults.standard.data(forKey: "SavedUser") {
            do {
                let temp = try JSONDecoder().decode(User.self, from: savedValue)
                self.setupSharedInstance(user: temp)
                print("Cashe Successfully fetched")
            } catch {
                print("Cashe failed to fetch")
                loadData()
            }
        }else{
            loadData()
        }
//
//        if let temp = UserDefaults.standard.object(forKey: "faceBook" ) as? String{
//            faceBook = temp
//        }
//        if let temp = UserDefaults.standard.object(forKey: "instgram" ) as? String{
//            instgram = temp
//        }
//        if let temp = UserDefaults.standard.object(forKey: "email" ) as? String{
//            email = temp
//        }
//        if let temp = UserDefaults.standard.object(forKey: "linkedIn" ) as? String{
//            linkedIn = temp
//        }
//        if let temp = UserDefaults.standard.object(forKey: "phone" ) as? String{
//            phone = temp
//        }
//
//        experiances.removeAll()
//        if let temp = UserDefaults.standard.object(forKey: "experiances.count" ) as? Int{
//
//            for i in 0..<temp{
//                let expTemp = Experience()
//                if let temp2 = UserDefaults.standard.object(forKey: "experiances.name.\(i)" ) as? String{
//                    expTemp.name = temp2
//                }
//                if let temp2 = UserDefaults.standard.object(forKey: "experiances.icon.\(i)" ) as? String{
//                    expTemp.icon = temp2
//                }
//                if let temp2 = UserDefaults.standard.object(forKey: "experiances.date.\(i)" ) as? String{
//                    expTemp.date = temp2
//                }
//                experiances.append(expTemp)
//            }
//        }
        
        
    }
    
    private func setupSharedInstance(user:User){
        self.faceBook = user.faceBook
        self.instgram = user.instgram
        self.email = user.email
        self.linkedIn = user.linkedIn
        self.phone = user.phone
        self.experiances = user.experiances
        self.projects = user.projects
    }
    
    
    
}
