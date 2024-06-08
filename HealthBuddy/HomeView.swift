//
//  HomeView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/5/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    //var username: String
//    @State private var userProfile: UserProfile?
//    @State private var dailyLog: DailyNutritionLog?
//    
    @StateObject private var userManager: UserProfileManager
    
    init(username: String) {
        _userManager = StateObject(wrappedValue: UserProfileManager(username: username))
    }
    
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
                    Text("Welcome Back, \(userManager.username)!")
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
                        if let remainingCalories = userManager.dailyLog?.calorieLimit {
                            Text("\(remainingCalories - (userManager.dailyLog?.totalCalories() ?? 0.0))")
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
            //setUpUserProfile()
            userManager.setUpUserProfile()
        }

    }
//    private func setUpUserProfile(){
//        if let loadedProfile = UserProfileManager.loadUserProfile(username: username) {
//            print("loading profile")
//            userProfile = loadedProfile
//            if let todayLog = loadedProfile.history.first(where: { Calendar.current.isDateInToday($0.date) }){
//                print("loading log for today")
//                dailyLog = todayLog
//            }else{
//                print("creating log for today")
//                let newLog = DailyNutritionLog(date: Date())
//                dailyLog = newLog
//                userProfile?.history.append(newLog)
//                UserProfileManager.saveUserProfile(loadedProfile)
//            }
//        } else {
//            let newUserProfile = UserProfile(username: username, history: [], addedFoodItems: [])
//            userProfile = newUserProfile
//            let newLog = DailyNutritionLog()
//            dailyLog = newLog
//            userProfile?.history.append(newLog)
//            UserProfileManager.saveUserProfile(newUserProfile)
//            print("making profile and log")
//        }
//        
////        if let profile = userProfile {
////            dailyLog = profile.history.first 
////        }
//    }
}





#Preview {
    HomeView(username: "Johnny")
}

