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
    @State private var toCreateFoodView = false
    @State private var isInSearchView = false
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
            ZStack{
            TabView {
                VStack {
                    Text("Welcome Back, \(userManager.username)!")
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
                    List {
                        ForEach(userManager.dailyLog?.foodItems ?? []) { foodItem in
                            VStack(alignment: .leading) {
                                Text(foodItem.productName)
                                    .font(.headline)
                                Text(foodItem.brandName)
                                    .font(.subheadline)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    Spacer()
                    
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                SearchView(isInSearchView: $isInSearchView).environmentObject(userManager)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isInSearchView {
                        Button(action: {
                            toCreateFoodView = true
                            //print("Checkmark tapped")
                        }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
                NavigationLink(
                    destination: CreateFoodItemView().environmentObject(userManager),
                    isActive: $toCreateFoodView,
                    label: {
                        EmptyView()
                    }
                )
        }
    }
        
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            userManager.setUpUserProfile()
            if let firstFoodItemName = userManager.dailyLog?.foodItems.first?.productName {
                print("First food item name: \(firstFoodItemName)")
            } else {
                print("No food items available")
            }
        }

    }

}





#Preview {
    HomeView(username: "Johnny")
}

