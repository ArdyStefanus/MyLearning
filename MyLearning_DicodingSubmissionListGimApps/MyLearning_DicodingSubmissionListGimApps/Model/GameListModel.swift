//
//  GameListModel.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import Foundation
import SwiftyJSON
import CoreData

struct ListGameRawg {
    var id: Int
    var name: String
    var released: String
    var rating: Double
    var backgroundImage: String
    var deskripsi: String
    
    init(data: JSON) {
        self.id = data["id"].int ?? 0
        self.name = data["name"].string ?? ""
        self.released = data["released"].string ?? ""
        self.rating = data["rating"].double ?? 0.0
        self.backgroundImage = data["background_image"].string ?? ""
        self.deskripsi = data["description"].string ?? ""
    }
    
    init(id: Int, name: String, rilis: String, rating: Double, backgroundImage: String, deskripsi: String){
        self.id = id
        self.name = name
        self.released = rilis
        self.rating = rating
        self.backgroundImage = backgroundImage
        self.deskripsi = deskripsi
    }
}
