//
//  Experience.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/25/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import Foundation
import UIKit


class ExperienceSection :Decodable{
    var sectionName : String?
    var experiences : [Experience]?
    
}

class Experience :Decodable{
    var icon : String?
    var name : String?
    var date : String?
    
    
}
