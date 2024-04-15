//
//  Google_SignIn.swift
//  pmToolMobile
//
//  Created by Sachin on 16/08/23.
//

import SwiftUI
import Firebase
import GoogleSignIn


 class SignIn_withGoogle_VM: ObservableObject {
    @Published var isLoginSucessed = false
     @Published var signIn = false
     @Published var token:String=""
     
     func signInWithGoogle() {
        
       // get client ID
        guard let ClientId=FirebaseApp.app()?.options.clientID else{
            return
        }
        
        //Configuration Object
        let config = GIDConfiguration(clientID: ClientId)
        GIDSignIn.sharedInstance.configuration=config
        
        //SignIn Method
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController){ user,error in
            if let error=error{
                print(error.localizedDescription)
                return
            }
            
            guard let user = user?.user,
                 let idToken = user.idToken else {
                return
                
            }
            
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken:idToken.tokenString,accessToken:accessToken.tokenString)
           
            Auth.auth().signIn(with: credential){ [self]
                res, erroe in
                if let error = error {
                    print("Errorr",error.localizedDescription)
                    return
                }
                guard let user = res?.user else{
                    self.isLoginSucessed=true
                    self.isLoginSucessed=true
                    return
                   
                    
                }
                token = idToken.tokenString  // This is the unique user ID
                print("Tokenn:", token)
                print("Userrrr",user.displayName)
                print("Userrrr",user.email)
                
                ViewModelFeeds().feedPosts(
                    token:token
                )
                
            }
        }
    }
    
}


