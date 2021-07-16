//
//  Model.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 29.06.2021.
//

import Foundation
import SwiftUI

import FirebaseFirestore
import FirebaseFirestoreSwift
struct  ModelJson: Hashable ,Codable ,Identifiable {
    
    var id:Int
        var section, word,wordrandom, image1, image2: String
    var image3, image4: String
    
}




