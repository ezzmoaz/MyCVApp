//
//  Project.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 6/25/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import Foundation


class Project :Decodable{
    var mainImage : String?
    var name : String?
    var description : String?
    var duration : String?
    var progLang : String?
    var screens : [String]?
    var appStore : String?
    var github : String?
    var other : String?
    var disclaimerName : String?
    var disclaimerImage : String?
    var isAppStore : Bool?
    var isGithub : Bool?
    var isOther : Bool?
    var isDisclaimer : Bool?
    var isNew : Bool?
}
