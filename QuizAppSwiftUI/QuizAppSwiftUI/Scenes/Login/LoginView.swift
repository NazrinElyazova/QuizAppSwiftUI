//
//  ContentView.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import SwiftUI

struct LoginView: View {
    @State var userID: String = ""
    @State var shouldLogout: Bool? = false
    
    var body: some View {
        if userID.isEmpty {
            Button("Login", systemImage: "door.right.hand.closed") {
                login()
            }
        } else {
            QuizStartView(logout: $shouldLogout)
                .onChange(of: shouldLogout) { oldValue, newValue in
                    if newValue! {
                        userID = ""
                    }
                }
        }
   
    }
    
    private func login() {
        // 3rd part integration package dependency
        userID = "abcd"
    }
}

#Preview {
    LoginView()
}
