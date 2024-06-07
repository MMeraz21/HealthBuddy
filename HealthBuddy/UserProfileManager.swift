//
//  UserProfileManager.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/7/24.
//

import Foundation

class UserProfileManager {
    
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
}
