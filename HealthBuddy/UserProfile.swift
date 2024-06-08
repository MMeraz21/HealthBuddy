//
//  UserProfile.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/5/24.
//

import Foundation

class UserProfile: Codable{
    var username: String
    var history: [DailyNutritionLog]
    var addedFoodItems: [FoodItem]
    
    init(username: String, history: [DailyNutritionLog] = [], addedFoodItems: [FoodItem] = []) {
        self.username = username
        self.history = history
        self.addedFoodItems = addedFoodItems
    }
    
    func setupDailyLog(for date: Date) -> DailyNutritionLog{
        if let todayLog = history.first(where: {Calendar.current.isDate($0.date, inSameDayAs: date)}){
            return todayLog
        }else{
            let newLog = DailyNutritionLog(date: date)
            history.append(newLog)
            return newLog
        }
    }
    
}
