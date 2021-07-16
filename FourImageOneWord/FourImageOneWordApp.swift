//
//  FourImageOneWordApp.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 25.06.2021.
//

import SwiftUI
import Firebase
@main
struct FourImageOneWordApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        let firstScore : Int = UserDefaults.standard.integer(forKey: "firstScore")
        
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView(model: ModelJson(id: 0, section: "", word: "", wordrandom: "", image1: "", image2: "", image3: "", image4: ""), sectionRowModel: SectionRowViewModel(model: ModelFirebase(userId: "", id: "", score:firstScore, imagesId: 0)))
                .environmentObject(viewModel)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        return true
    }
    
}
