//
//  SectionListModel.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 6.07.2021.
//
import Foundation
import Combine

class SectionListViewModel: ObservableObject{
    
    @Published var sectionRowModel = [SectionRowViewModel]()
    @Published var modelRepository = RepositoryFirebase()
    private var cancellabels = Set<AnyCancellable>()
    
    init(){
        modelRepository.$modelF.map{
            models in
            models.map { model in
                SectionRowViewModel(model: model)
            }
        }.assign(to: \.sectionRowModel , on: self)
        .store(in: &cancellabels)
    }
    func addTask(model:ModelFirebase){
        modelRepository.add(model: model)
        
    }
    
    func updateTask(model:ModelFirebase){
        modelRepository.update(model: model)
    }
}
