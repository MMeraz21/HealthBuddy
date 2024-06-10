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
    
    @State private var calLimit: String = ""
    @State private var fatLimit: String = ""
    @State private var proteinLimit: String = ""
    @State private var carbsLimit: String = ""
    @State private var sugarLimit: String = ""
    
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
                //ScrollView{
                TabView {
                    ScrollView{
                    VStack {
                        Text("Welcome Back, \(userManager.username)!")
                            .foregroundColor(.blue)
                            .padding(.top, 20)
                        
                        Text(todayDate)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                        

                        
                        //Spacer()
                        
                        VStack {
                            VStack{
                                HStack{
                                    Text("Calorie Goal:")
                                    if let remainingCalories = userManager.dailyLog?.calorieLimit {
                                        let remainingCaloriesString = String(format: "%.0f", remainingCalories - (userManager.dailyLog?.totalCalories() ?? 0.0))
                                        Text(remainingCaloriesString)
                                    } else {
                                        Text("No data available")
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    TextField(String(userManager.dailyLog?.calorieLimit ?? 0.0), text: $calLimit)
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal)
                                        .frame(width: 100)
                                        .onChange(of: calLimit) { newValue in
                                            if let newCalorieLimit = Double(newValue) {
                                                userManager.dailyLog?.calorieLimit = newCalorieLimit
                                            }
                                        }
                                    
                                    
                                }
                                .padding()
                                if let remainingCalories = userManager.dailyLog?.calorieLimit {
                                    let totalCalories = userManager.dailyLog?.totalCalories() ?? 0.0
                                    let progress = min(totalCalories / remainingCalories, 1.0)
                                    
                                    ProgressView(value: progress)
                                        .padding()
                                }
                            }
                            VStack {
                                HStack {
                                    Text("Fat Goal:")
                                    if let remainingFat = userManager.dailyLog?.fatLimit {
                                        let remainingFatString = String(format: "%.0f", remainingFat - (userManager.dailyLog?.totalFat() ?? 0.0))
                                        Text(remainingFatString)
                                    } else {
                                        Text("No data available")
                                    }
                                    
                                    Spacer()
                                    
                                    TextField(String(userManager.dailyLog?.fatLimit ?? 0.0), text: $fatLimit)
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal)
                                        .frame(width: 100)
                                        .onChange(of: fatLimit) { newValue in
                                            if let newFatLimit = Double(newValue) {
                                                userManager.dailyLog?.fatLimit = newFatLimit
                                            }
                                        }
                                }
                                .padding()
                                if let remainingFat = userManager.dailyLog?.fatLimit {
                                    let totalFat = userManager.dailyLog?.totalFat() ?? 0.0
                                    let progress = min(totalFat / remainingFat, 1.0)
                                    
                                    ProgressView(value: progress)
                                        .padding()
                                }
                            }
                            
                            VStack {
                                HStack {
                                    Text("Protein Goal:")
                                    if let remainingProtein = userManager.dailyLog?.proteinLimit {
                                        let remainingProteinString = String(format: "%.0f", remainingProtein - (userManager.dailyLog?.totalProtein() ?? 0.0))
                                        Text(remainingProteinString)
                                    } else {
                                        Text("No data available")
                                    }
                                    
                                    Spacer()
                                    
                                    TextField(String(userManager.dailyLog?.proteinLimit ?? 0.0), text: $proteinLimit)
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal)
                                        .frame(width: 100)
                                        .onChange(of: proteinLimit) { newValue in
                                            if let newProteinLimit = Double(newValue) {
                                                userManager.dailyLog?.proteinLimit = newProteinLimit
                                            }
                                        }
                                }
                                .padding()
                                if let remainingProtein = userManager.dailyLog?.proteinLimit {
                                    let totalProtein = userManager.dailyLog?.totalProtein() ?? 0.0
                                    let progress = min(totalProtein / remainingProtein, 1.0)
                                    
                                    ProgressView(value: progress)
                                        .padding()
                                }
                            }
                            
                            VStack {
                                HStack {
                                    Text("Carbs Goal:")
                                    if let remainingCarbs = userManager.dailyLog?.carbLimit {
                                        let remainingCarbsString = String(format: "%.0f", remainingCarbs - (userManager.dailyLog?.totalCarbs() ?? 0.0))
                                        Text(remainingCarbsString)
                                    } else {
                                        Text("No data available")
                                    }
                                    
                                    Spacer()
                                    
                                    TextField(String(userManager.dailyLog?.carbLimit ?? 0.0), text: $carbsLimit)
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal)
                                        .frame(width: 100)
                                        .onChange(of: carbsLimit) { newValue in
                                            if let newCarbsLimit = Double(newValue) {
                                                userManager.dailyLog?.carbLimit = newCarbsLimit
                                            }
                                        }
                                }
                                .padding()
                                if let remainingCarbs = userManager.dailyLog?.carbLimit {
                                    let totalCarbs = userManager.dailyLog?.totalCarbs() ?? 0.0
                                    let progress = min(totalCarbs / remainingCarbs, 1.0)
                                    
                                    ProgressView(value: progress)
                                        .padding()
                                }
                            }
                            VStack {
                                HStack {
                                    Text("Sugar Goal:")
                                    if let remainingSugar = userManager.dailyLog?.sugarLimit {
                                        let remainingSugarString = String(format: "%.0f", remainingSugar - (userManager.dailyLog?.totalSugar() ?? 0.0))
                                        Text(remainingSugarString)
                                    } else {
                                        Text("No data available")
                                    }
                                    
                                    Spacer()
                                    
                                    TextField(String(userManager.dailyLog?.sugarLimit ?? 0.0), text: $sugarLimit)
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal)
                                        .frame(width: 100)
                                        .onChange(of: sugarLimit) { newValue in
                                            if let newSugarLimit = Double(newValue) {
                                                userManager.dailyLog?.sugarLimit = newSugarLimit
                                            }
                                        }
                                }
                                .padding()
                                if let remainingSugar = userManager.dailyLog?.sugarLimit {
                                    let totalSugar = userManager.dailyLog?.totalSugar() ?? 0.0
                                    let progress = min(totalSugar / remainingSugar, 1.0)
                                    
                                    ProgressView(value: progress)
                                        .padding()
                                }
                            }
                            
                            
                            
                            
                            
                        }                        
                        
//                                                    List {
//                                                        ForEach(userManager.dailyLog?.foodItems ?? []) { foodItem in
//                                                            VStack(alignment: .leading) {
//                                                                Text(foodItem.productName)
//                                                                    .font(.headline)
//                                                                Text(foodItem.brandName)
//                                                                    .font(.subheadline)
//                                                            }
//                                                            .padding(.vertical, 8)
//                                                        }
//                                                    }
//                                                    .listStyle(InsetGroupedListStyle())
                        
                        //Spacer()
                        
                    }
                }
                        .onTapGesture() {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                        
                        HistoryView().environmentObject(userManager)
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
            
        //}
    }

}





#Preview {
    HomeView(username: "Johnny")
}

