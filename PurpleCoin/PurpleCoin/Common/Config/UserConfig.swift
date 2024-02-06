//
//  UserConfig.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/15.
//

import Foundation

final class UserConfig { 
    static let shared = UserConfig()
    let userDefaults = UserDefaults()
    
    private enum Keys {
        static let interestedCoins = "interestedCoins"
    }
    
    var intrestedCoins: [String] {
        get {
            let savedData = userDefaults.stringArray(forKey: Keys.interestedCoins) ?? []
            return savedData
        }
        set {
            userDefaults.set(newValue, forKey: Keys.interestedCoins)
            userDefaults.synchronize()
        }
    }
}
