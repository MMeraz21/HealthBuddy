//
//  HomeView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/5/24.
//

import SwiftUI

struct HomeView: View {
    var username: String
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Text("Home")
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Text("HealthBuddy").font(.title).foregroundColor(.blue))


        }
        .navigationBarHidden(true)

    }
}




#Preview {
    HomeView(username: "Johnny")
}
