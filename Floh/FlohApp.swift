//
//  FlohApp.swift
//  Floh
//
//  Created by Abdussamed Sen on 13.01.24.
//
// Client ID :783066739557-f1a423bk94vuka6pp5afrg8c0lspv285.apps.googleusercontent.com

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct FlohApp: App {
    @StateObject var fireStoreManager = FireStoreManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
    }
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(viewModel)
        }
    }
}

extension FlohApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
