//
//  FoodItem.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 5/31/24.
//

import Foundation

class FoodItem: Identifiable, Codable{
    var productName: String = ""
    var brandName: String = ""
    var protein: Double = 0.0
    var sugar: Double = 0.0
    var calories: Double = 0.0
    var carbs: Double = 0.0
    var fat: Double = 0.0
    var servingGrams: Double = 0.0
    
    init(productName: String, brandName: String, protein: Double, sugar: Double, calories: Double, carbs: Double, fat: Double, servingGrams: Double) {
        self.productName = productName
        self.brandName = brandName
        self.protein = protein
        self.sugar = sugar
        self.calories = calories
        self.carbs = carbs
        self.fat = fat
        self.servingGrams = servingGrams
    }
    
    convenience init() {
        self.init(productName: "", brandName: "", protein: 0.0, sugar: 0.0, calories: 0, carbs: 0.0, fat: 0.0, servingGrams: 0.0)
    }
    
}
