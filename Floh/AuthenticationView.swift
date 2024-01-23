//
//  AuthenticationView.swift
//  Floh
//
//  Created by Abdussamed Sen on 23.01.24.
//

import SwiftUI
import Firebase

struct AuthenticationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    
    
    var body: some View {
        VStack{
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action:{ login() }) {
                Text("Sign In")
            }
            .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Login Successful"),
                        message: Text("Du kannst auch alles")
                    )
            }
        }
        .padding()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                showAlert = true
            } else {
                print("success")
                showAlert = true
            }
            
        }
    }
}

#Preview {
    AuthenticationView()
}
