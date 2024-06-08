//
//  UserProfileManager.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/7/24.
//

import Foundation

class UserProfileManager: ObservableObject{
    var username: String
    @Published var userProfile: UserProfile?
    @Published var dailyLog: DailyNutritionLog?
    
    init(username: String) {
        self.username = username
    }
    
     func setUpUserProfile(){
        if let loadedProfile = UserProfileManager.loadUserProfile(username: username){
            print("loading profile")
            userProfile = loadedProfile
            dailyLog = userProfile?.setupDailyLog(for: Date())
        }else{
            let newUserProfile = UserProfile(username: username)
            userProfile = newUserProfile
            dailyLog = newUserProfile.setupDailyLog(for: Date())
            UserProfileManager.saveUserProfile(newUserProfile)
            print("making profile")
        }
    }
    
    static func saveUserProfile(_ userProfile: UserProfile) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userProfile) {
            UserDefaults.standard.set(encoded, forKey: "userProfile-\(userProfile.username)")
        }
    }
    
    static func loadUserProfile(username: String) -> UserProfile? {
        if let savedUserProfileData = UserDefaults.standard.object(forKey: "userProfile-\(username)") as? Data {
            let decoder = JSONDecoder()
            if let loadedUserProfile = try? decoder.decode(UserProfile.self, from: savedUserProfileData) {
                return loadedUserProfile
            }
        }
        return nil
    }
    
    func saveProfile(){
        if let profile = userProfile{
            UserProfileManager.saveUserProfile(profile)
        }
    }
}
