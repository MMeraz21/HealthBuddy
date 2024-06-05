//
//  UserProfile.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/5/24.
//

import Foundation

class UserProfile{
    var username: String
    var history: [DailyNutritionLog]
    var addedFoodItems: [FoodItem]
    
    init(username: String, history: [DailyNutritionLog], addedFoodItems: [FoodItem]) {
        self.username = username
        self.history = history
        self.addedFoodItems = addedFoodItems
    }
    
    
}
