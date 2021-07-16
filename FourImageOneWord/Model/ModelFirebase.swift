//
//  ModelFirebase.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 6.07.2021.
//
import Foundation
import SwiftUI

import FirebaseFirestore
import FirebaseFirestoreSwift
struct  ModelFirebase:  Codable ,Identifiable {

    var userId : String?
    var id:String?
    var score: Int
    var imagesId:Int
    

}
