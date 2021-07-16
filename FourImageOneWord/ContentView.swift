//
//  ContentView.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 25.06.2021.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    @ObservedObject var sectionListModel = SectionListViewModel()
    @ObservedObject var sectionRowModel : SectionRowViewModel
    var modelRepository : RepositoryFirebase
    
    let userId = Auth.auth().currentUser?.uid
    
    @Published var signedIn = false
    init() {
        self.modelRepository = RepositoryFirebase()
        self.sectionRowModel = SectionRowViewModel(model: ModelFirebase(userId: userId, id: UUID().uuidString, score: 0, imagesId: 0))
    }
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    func signedIn (email:String,password:String){
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil ,error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
                self!.modelRepository.loadData()
                
            }
        }
    }
    func signedUp(email:String,password:String){
        auth.createUser(withEmail: email, password: password) { [weak self ]result, error in
            guard result != nil ,error == nil else{
                return
            }
            DispatchQueue.main.async { [self] in
                self?.signedIn = true
                let userId = Auth.auth().currentUser?.uid
                
                self!.sectionListModel.addTask(model: ModelFirebase(userId: userId!, id: UUID().uuidString, score: self!.sectionRowModel.modelF.score, imagesId: self!.sectionRowModel.modelF.imagesId))
            }
            
        }
    }
    func signOut(){
        
        try? auth.signOut()
        self.signedIn = false
    }
}
struct ContentView: View {
    var model :ModelJson
    @EnvironmentObject var viewModel : AppViewModel
    @ObservedObject var sectionRowModel: SectionRowViewModel
    var body: some View {
        NavigationView {
            VStack{
                if viewModel.signedIn {
                   /* SectionListView(sectionRowModel: SectionRowViewModel(model: ModelFirebase(userId: "", id: "", score: sectionRowModel.modelF.score, imagesId: sectionRowModel.modelF.imagesId)), modelRepository: RepositoryFirebase())*/
                    SectionDetail(model: model, modelfirebase: ModelFirebase(userId: "", id: "", score: 0, imagesId: 0), sectionRowModel: SectionRowViewModel(model: ModelFirebase(userId: "", id: "", score: 0, imagesId: 0)), modelRepository: RepositoryFirebase(), success: false, score: .constant(0), hiddenButton: [false])
                   
                    Button (action: {
                        viewModel.signOut()
                    }) {
                        Text("🦥Quit")
                            .font(.custom("Noteworthy-Bold",size: 15))
                            .frame(width: 50, height: 50)
                            .background(Image("backgrnd5"))
                            .foregroundColor(Color.black)
                            .cornerRadius(30)
                            .padding()
                            //.position(CGPoint(x: 30, y: 0) )
                        
                    }        

                    
                }else{
                    SignInView()
                }
                Spacer()
            }
        }.onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(model:ModelJson(id: 0, section: "", word: "", wordrandom: "", image1: "", image2: "", image3: "", image4: ""), sectionRowModel: SectionRowViewModel(model: ModelFirebase(userId: "", id: "", score: 40, imagesId: 0)))
        
    }
}


