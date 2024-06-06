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
    var userProfile: UserProfile?
    var dailyLog: DailyNutritionLog?
    
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

    }
}




#Preview {
    HomeView(username: "Johnny", userProfile: UserProfile(username: "Johnny", history: [], addedFoodItems: []))
}

