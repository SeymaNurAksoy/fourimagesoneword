//
//  ModelFirebaseImagesAndWords.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 13.07.2021.
//

import Foundation
struct  ModelFirebaseImagesAndWords : Codable ,Identifiable {

    var userId : String?
    var id:String?
    var score: Int
    var section, word,wordrandom, image1, image2: String
    var image3, image4: String
    

}
