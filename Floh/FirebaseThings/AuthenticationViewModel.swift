//
//  AuthenticationViewModel.swift
//  Floh
//
//  Created by Abdussamed Sen on 31.01.24.
//
import Foundation
import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    func signIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            _ = GIDConfiguration(clientID: clientID)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
                authenticateUser(for: result?.user, with: error)
            }
        }
    }
    
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let idToken = user?.idToken, let userAToken = user?.accessToken else {
            print("Error: ID token or access token is nil")
            return
        }

        print("ID Token: \(idToken)")
        print("Access Token: \(userAToken)")

        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: userAToken.tokenString)
          
          // 3
          Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
              print(error.localizedDescription)
            } else {
              state = .signedIn
            }
          }
    }
    
    func signOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()
        
        do {
            // 2
            try Auth.auth().signOut()
            
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
