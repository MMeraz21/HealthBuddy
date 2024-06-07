//
//  DailyNutritionLog.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/4/24.
//

import Foundation

class DailyNutritionLog: Codable {
    var foodItems: [FoodItem]
    var date: Date
    var calorieLimit: Double
    var fatLimit: Double
    var proteinLimit: Double
    var carbLimit: Double
    var sugarLimit: Double
    
    init(foodItems: [FoodItem] = [], date: Date = Date(), calorieLimit: Double, fatLimit: Double, proteinLimit: Double, carbLimit: Double, sugarLimit: Double) {
        self.foodItems = foodItems
        self.date = date
        self.calorieLimit = calorieLimit
        self.fatLimit = fatLimit
        self.proteinLimit = proteinLimit
        self.carbLimit = carbLimit
        self.sugarLimit = sugarLimit
    }
    
    func addFoodItem(_ foodItem: FoodItem) {
        foodItems.append(foodItem)
    }
    
    func totalCalories() -> Double {
        return foodItems.reduce(0) { $0 + $1.calories }
    }
    
    func totalFat() -> Double {
        return foodItems.reduce(0) { $0 + $1.fat }
    }
    
    func totalProtein() -> Double {
        return foodItems.reduce(0) { $0 + $1.protein }
    }
    
    func totalCarbs() -> Double {
        return foodItems.reduce(0) { $0 + $1.carbs }
    }
    
    func totalSugar() -> Double {
        return foodItems.reduce(0) { $0 + $1.sugar }
    }
    
}
