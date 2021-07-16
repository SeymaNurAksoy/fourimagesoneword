//
//  SectionListView.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 1.07.2021.
//

import SwiftUI
import FirebaseAuth
import Firebase
struct SectionListView: View {
    @ObservedObject var sectionListModel = SectionListViewModel()

    @ObservedObject var sectionRowModel: SectionRowViewModel
    var modelRepository : RepositoryFirebase
    var body: some View {
        NavigationView {
            VStack{
                
                ForEach(sectionListModel.sectionRowModel){ task in
                    Text("SCORE : " + String(task.score))
                    
                }
                    .font(.custom("Noteworthy-Bold",size: 30))
                
                List(models) { welcome in
                    
                    
                    
                    NavigationLink(destination: SectionDetail(model: welcome, modelfirebase: ModelFirebase(userId: "", id: "", score: sectionRowModel.modelF.score, imagesId: sectionRowModel.modelF.imagesId), sectionRowModel: SectionRowViewModel(model: ModelFirebase(userId: "", id: "", score: sectionRowModel.modelF.score, imagesId: sectionRowModel.modelF.imagesId)), sectionListModel: SectionListViewModel(), modelRepository: RepositoryFirebase(),  score: $sectionRowModel.modelF.score, hiddenButton: [false])) {
                        SectionRowView(model: welcome)
                        
                    }
                    
                    
                }.navigationBarTitle("SECTIONS",displayMode: .inline)
            }
            
        }.onAppear() {
            UserDefaults.standard.set(sectionRowModel.modelF.score, forKey: "firstScore")
            print(" 🥶🥶🥶🥶🥶" + String(sectionRowModel.modelF.score))
            let firstScore : Int = UserDefaults.standard.integer(forKey: "firstScore")
            print(" 🍇🍇🍇🍇🍇" )
            print(firstScore)
            
        }
    }
    
}

struct SectionListView_Previews: PreviewProvider {
 //   @ObservedObject var sectionRowModel: SectionRowViewModel
 static var previews: some View {
 Group {
    SectionListView(sectionRowModel: SectionRowViewModel(model: ModelFirebase(userId: "", id: "", score: 89, imagesId: 0)), modelRepository: RepositoryFirebase())
 
 }
 }
 }
