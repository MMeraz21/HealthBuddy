//
//  HomeView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/5/24.
//

import SwiftUI

struct HomeView: View {
    var username: String
    var userProfile: UserProfile?
    var dailyLog: DailyNutritionLog?
    
    var body: some View {
        NavigationView {
            //Text("hello")
            TabView {
                VStack {
                    Text("Welcome Back, \(username)!")
                    
                }

                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                VStack{
                    Text("Add")
                }
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
                VStack{
                    Text("History")
                }
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("History")
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Text("HealthBuddy").font(.title).foregroundColor(.blue))


        }
        .navigationBarHidden(true)

    }
}




#Preview {
    HomeView(username: "Johnny", userProfile: UserProfile(username: "Johnny", history: [], addedFoodItems: []))
}

