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
    
    init(foodItems: [FoodItem] = [], date: Date = Date(), calorieLimit: Double = 2000, fatLimit: Double = 70, proteinLimit: Double = 50, carbLimit: Double = 300, sugarLimit: Double = 90) {
        self.foodItems = foodItems
        self.date = date
        self.calorieLimit = calorieLimit
        self.fatLimit = fatLimit
        self.proteinLimit = proteinLimit
        self.carbLimit = carbLimit
        self.sugarLimit = sugarLimit
    }
    
    func dateToString()->String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
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
