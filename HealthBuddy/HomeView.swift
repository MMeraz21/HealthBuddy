//
//  HomeView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/5/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    var username: String
    @State private var userProfile: UserProfile?
    @State private var dailyLog: DailyNutritionLog?
    
    var todayDate: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
    
    var body: some View {
        NavigationView {
            //Text("hello")
            TabView {
                VStack {
                    Text("Welcome Back, \(username)!")
                        //.font(.largeTitle)
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    
                    Text(todayDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                    
                    Spacer()
                    
                    VStack {
                        Text("Calorie Goal:")
                        if let remainingCalories = dailyLog?.calorieLimit {
                            Text("\(remainingCalories - (dailyLog?.totalCalories() ?? 0.0))")
                        } else {
                            Text("No data available")
                        }
                    }
                    
                    Spacer()
                    
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                SearchView()
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
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            setUpUserProfile()
        }

    }
    private func setUpUserProfile(){
        if let loadedProfile = UserProfileManager.loadUserProfile(username: username) {
            print("loading profile")
            userProfile = loadedProfile
        } else {
            let newUserProfile = UserProfile(username: username, history: [], addedFoodItems: [])
            userProfile = newUserProfile
            UserProfileManager.saveUserProfile(newUserProfile)
            print("making profile")
        }
        
        // Initialize dailyLog or load from userProfile if needed
        if let profile = userProfile {
            dailyLog = profile.history.first // Example: Load the first log
        }
    }
}





#Preview {
    HomeView(username: "Johnny")
}

