//
//  StartView.swift
//  Floh
//
//  Created by Abdussamed Sen on 31.01.24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        switch viewModel.state {
        case .signedIn: ContentView()
        case .signedOut: LoginView()
        }
    }
}

#Preview {
    StartView()
}
