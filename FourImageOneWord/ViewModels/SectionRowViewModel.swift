//
//  SectionRowModel.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 6.07.2021.

import Foundation
import Combine
import SwiftUI
class SectionRowViewModel: ObservableObject,Identifiable{
    @Published var modelF:ModelFirebase
    
    var userId = ""
    var id = ""
    @Published var score = 0
    @Published var imagesId = 0
    private var cancellables = Set<AnyCancellable>()
    
    init(model : ModelFirebase) {
        self.modelF = model
        $modelF .map{ model in
            model.score
        }
        .assign(to: \.score,on: self)
        .store(in: &cancellables)
        
        $modelF .map{ model in
            model.imagesId
        }
        .assign(to: \.imagesId,on: self)
        .store(in: &cancellables)
        
        $modelF.compactMap{ model in
            model.id
        }
        .assign(to: \.id , on: self)
        .store(in: &cancellables)
        
        $modelF.compactMap{ model in
            model.userId
        }
        .assign(to: \.userId , on: self)
        .store(in: &cancellables)
        
        print("🌸🌸🌸🌸🌸")
        print(model.score)
        
    }
    
}
