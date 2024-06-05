//
//  ContentView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 5/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""

    
    var body: some View {
        VStack{
            Text("HealthBuddy")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.top, 16)
            
            Spacer()
            
            TextField("Enter your username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(40)
                .padding(.horizontal, 20)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Spacer()
            
            NavigationLink(destination: HomeView(username: username)) {
                Text("Login")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

