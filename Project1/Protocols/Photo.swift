//
//  photos.swift
//  Project1
//
//  Created by Alrzbod on 6/23/22.
//

import Foundation

import SwiftyJSON

struct Photo {
    
var bigImageURL: String
var smallImageURL: String

    init?(json: JSON) {
        
    guard let urlQ = json["url_q"].string,
    let urlZ = json["url_z"].string else {
        
    return nil
        
    }
        
    self.bigImageURL = urlZ
    self.smallImageURL = urlQ
    }
    
    //config Stract & Codable
    
    
}
