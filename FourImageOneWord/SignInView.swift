//
//  SignInView.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 6.07.2021.
//

import SwiftUI

struct SignInView: View {
    @State var password  = ""
    
    @State var email  = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        
        VStack{
            VStack{
                Spacer()
                Text("SIGN IN").foregroundColor(.yellow)
                    
                    .font(.custom("Noteworthy-Bold",size: 40))
                
                Image("title").resizable()
                    .frame(width: 250, height: 50, alignment: .center).padding()
                TextField("email ",text : $email).padding()
                    .background(Color(.systemGroupedBackground))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField("password", text: $password).padding()
                    .background(Color(.systemGroupedBackground))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                Button(action:{
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    viewModel.signedIn(email: email, password: password)
                    
                }){
                    Text("Sign In")
                        .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(.black)
                        .background(Image("backgrnd4"))
                        .cornerRadius(30)
                        .font(.custom("Noteworthy-Bold",size: 30))
                    
                }
                
                
                NavigationLink("Create Account", destination: SignUpView())
                    .foregroundColor(.yellow)
                    .font(.custom("Noteworthy-Bold",size: 30))
                    .padding()
                Spacer()
            }
            .padding()
            
            Spacer()
        }.background(Image("backgrnd5").resizable().edgesIgnoringSafeArea(.all)
                        .frame(width: 1000, height: 900))
        
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
