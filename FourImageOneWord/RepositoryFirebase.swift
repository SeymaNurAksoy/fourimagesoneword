//
//  RepositoryFirebase.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 6.07.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class RepositoryFirebase : ObservableObject {
    let db = Firestore.firestore()
    @Published var modelF = [ModelFirebase]()
    
    init(){
        loadData()
    }
    func loadData(){
        let userId = Auth.auth().currentUser?.uid
        UserDefaults.standard.set(userId, forKey: "userId")
        db.collection("scores")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener {( querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    
                    querySnapshot.documentChanges.forEach
                    {
                        diff in
                        if (diff.type == .added)
                        {
                            let data = diff.document.data() as? NSDictionary
                            print("🌈🌈🌈🌈🌈🌈")
                            print(data)
                            self.modelF = querySnapshot.documents.compactMap({ document in
                                do{
                                    let x = try document.data(as: ModelFirebase.self)
                                    return x
                                }catch{
                                    print(error)
                                }
                                return nil
                            })
                            //                    print("data içi add \(diff.document.data())")
                            
                        }
                        if (diff.type == .modified)
                        {
                            self.modelF = querySnapshot.documents.compactMap({ document in
                                do{
                                    let x = try document.data(as: ModelFirebase.self)
                                    return x
                                }catch{
                                    print(error)
                                }
                                return nil
                            })
                        }
                    }
                }
            }
    }
    
    func add(model:ModelFirebase){
        
        do{
            var addedModel = model
            addedModel.userId = Auth.auth().currentUser!.uid
            let _ = try db.collection("scores").document(addedModel.userId!).setData(from: addedModel)
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    func update(model:ModelFirebase){
        let userUpdateId :String = UserDefaults.standard.string(forKey:"userId")!

        if model.id != nil{
            do{
                try db.collection("scores").document(userUpdateId).updateData(["score":model.score,"imagesId":model.imagesId])
                //print("aaaaaaaa"+modelID)
                print("bbbbb"+userUpdateId)
            }catch{
                fatalError(error.localizedDescription)
                
            }
        }
    }
}
