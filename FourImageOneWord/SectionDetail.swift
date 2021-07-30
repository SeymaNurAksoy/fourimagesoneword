//
//  SectionDetail.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 1.07.2021.
//

import SwiftUI
import FirebaseAuth
import Firebase
struct SectionDetail: View {
    var model : ModelJson
    var modelfirebase : ModelFirebase
    @ObservedObject var sectionRowModel: SectionRowViewModel
    @ObservedObject var sectionListModel = SectionListViewModel()
    var modelRepository : RepositoryFirebase
    @State var answer = ""
    @State var answer2 = ""
    @State var wordCount = 0
    @State var success :Bool = false
    @State var check = false
    @State private var control = false
    @Binding var score:Int
    let point:Int = 100
    @State var id:Int = 0
    @State var hidden = false
    @State var hiddenButton : [Bool]

    @State var isActive = true
    
    var body: some View {
        
        VStack(spacing:5){
            //kdjfdskdj
            ForEach(sectionListModel.sectionRowModel){ task in
                ZStack{
                    HStack{
                    Image("rate").resizable().frame(width: 50, height:50).zIndex(1)
                    Text("SCORE : " + String(task.score))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange, lineWidth: 4))
                        .shadow(color:Color.yellow.opacity(2),radius: 10,x:0,y:5)
                   // .background(Image("backgrnd3").resizable().frame(width:200,height:50))
                    .foregroundColor(.yellow)
                        .font(.custom("Noteworthy-Bold",size: 20)).padding()
                    }
                }
                if !isActive{
                    VStack{
                    Text("Heyyy Here's The Next Challenge ")
                        .foregroundColor(.yellow)
                        .font(.custom("Noteworthy-Bold",size: 15))

                        Text("Now Go Ahead And Get Your Score ➡️")
                            .font(.custom("Noteworthy-Bold",size: 15))
                            .foregroundColor(.yellow)
                           
                }
                }
                
                if (task.modelF.imagesId < 10){
                    HStack{
                        
                        Image( models[task.modelF.imagesId].image1 ).resizable().frame(width: 130, height: 130, alignment: .center) .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange, lineWidth: 4))
                            .shadow(radius: 10)
                        Image( models[task.modelF.imagesId].image2 ).resizable().frame(width: 130, height: 130, alignment: .center) .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange, lineWidth: 4))
                            .shadow(radius: 10)
                    }
                    HStack{
                        Image( models[task.modelF.imagesId].image3 ).resizable().frame(width: 130, height: 130, alignment: .center) .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange, lineWidth: 4))
                            .shadow(radius: 10)
                        Image( models[task.modelF.imagesId].image4) .resizable().frame(width: 130, height: 130, alignment: .center) .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange, lineWidth: 4))
                            .shadow(radius: 10)
                    }
                }
            }
            HStack{
                ForEach(sectionListModel.sectionRowModel){ task in
                    if task.modelF.imagesId < 10{
                        ForEach( Array(models[task.modelF.imagesId].wordrandom.enumerated()), id: \.offset) { i in
                        
                         
                            if !hidden{
                                Button(action: {
                                    
                                    answer += String (i.element)
                                    print(i.offset)
                                    //hiddenButton[i.offset].toggle()

                                    if models[task.modelF.imagesId].word == answer && task.modelF.imagesId<10{
                                        hidden.toggle()
                                        
                                        print("🍎🍎🍎🍎🍎")
                                        print(task.modelF.score)
                                        
                                        task.modelF.score += 100
                                        score = task.modelF.score
                                        success = true
                                        isActive.toggle()
                                        task.modelF.imagesId += 1
                                        
                                        sectionListModel.updateTask(model: ModelFirebase(userId:Auth.auth().currentUser!.uid, id: modelfirebase.id, score: task.modelF.score, imagesId: task.modelF.imagesId))
                                        answer += String(i.element)
                                        answer = ""
                                    }else{
                                        success = false
                                       
                                    }
                                }) {
                                    
                                    Text(String(i.element))
                                        .foregroundColor(.yellow)
                                        .font(.custom("Noteworthy-Bold",size: 30))
                                        
                                    
                                    //  Text(String(randomString(length: model.count)))
                                }
                                
                                .frame(width: 25, height: 25, alignment: .center)
                                
                                
                            }
                        }
                    }
                    
                }
                
            }
            
            ForEach(sectionListModel.sectionRowModel){ task in
                
                let rows = [GridItem(.adaptive(minimum: 20, maximum: 25))]
                LazyHGrid(rows: rows){
                    HStack{
                        ZStack{
                            HStack{
                        ForEach(Array(answer.enumerated()),id: \.offset){item in
                            Text(String(item.element))
                              //  .background(Color.purple)
                                .font(.custom("Noteworthy-Bold",size: 25))
                                
                                .foregroundColor(.yellow)
                                .onReceive(answer.publisher.collect()) {
                                    answer = String($0.prefix(models[                   task.modelF.imagesId].word.count))
                        
                                }
                            
                        }
                            }
                        }
                 
                                Text("_").foregroundColor(.yellow)
                                    .font(.custom("Noteworthy-Bold",size: 25))
                                
                    
                    }
                }
                Button(action: {
                    if success{
                        isActive = true
                        hidden = false
                        success = false
                        answer = ""
                        //  task.modelF.imagesId += 1
                        sectionListModel.updateTask(model: ModelFirebase(userId:Auth.auth().currentUser!.uid, id: modelfirebase.id, score: task.modelF.score, imagesId: task.modelF.imagesId))
                        
                    }
                }) {
                    Text("Continue")
                        .frame(width: 100, height: 50, alignment: .center)
                        .foregroundColor(.yellow)
                        .background(Image("backgrnd2"))
                        .cornerRadius(30)
                        .font(.custom("Noteworthy-Bold",size: 25))

                }
                Button(action: {
                    if success == false{
                        
                        success = false
                        answer = ""
                        
                    }
                }, label: {
                    Text("Delete")
                        .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(.blue)
                        .background(Image("backgrnd4"))
                        .cornerRadius(30)
                        .font(.custom("Noteworthy-Bold",size: 25))

                })
                if success{
                    HStack{
                        
                        Image("check").resizable()
                            
                            .frame(width:30,height:30)
                        Text("YOU SUCCESS 👏🤩🥳 ")
                            .foregroundColor(.yellow)

                            .font(.custom("Noteworthy-Bold",size: 25))

                    }
                    Text("YOU EARN " + String(point) + " POINTS")
                        .foregroundColor(.yellow)
                        .font(.custom("Noteworthy-Bold",size: 25))

                    
                }else{
                    Text(" TRY  🤩")
                        .font(.custom("Noteworthy-Bold",size: 25))
                        .foregroundColor(.yellow)

                    
                    
                }
            }
            
            Spacer()
            
            
        
            
            
        }.background(Image("backgrnd1").resizable().edgesIgnoringSafeArea(.all)
                      .frame(width: 1000, height: 900))
        
        
        .navigationBarHidden(false)
        .onAppear(){
            
            
            print("😊😊😊😊😊😊")
            print(sectionRowModel.modelF.score)
        }
    }
    
}



struct SectionDetail_Previews: PreviewProvider {
    var model : ModelJson
    var modelfirebase : ModelFirebase
    
    static var previews: some View {
        SectionDetail(model: models[0], modelfirebase: ModelFirebase(userId: "", id: "", score: 12, imagesId: 0), sectionRowModel: SectionRowViewModel(model: ModelFirebase(userId: "", id: "", score: 12, imagesId: 0)), sectionListModel: SectionListViewModel(), modelRepository: RepositoryFirebase(), success: false, score: .constant(12), hiddenButton: [false])
        
    }
}


