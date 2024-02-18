//
//  NetworkConfig.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import Foundation

final class NetworkConfig {
    
    static let shared = NetworkConfig()
    let userDefaults = UserDefaults.standard
    
    private enum Keys {
        static let allMarketCode = "allMarketCode"
        static let expiredTime = "expiredTime"
    }
    
    //base URL
    let baseURL = "https://api.upbit.com/v1"
    // 마켓 코드 만료 시간 간격(초)
    let expiredInterval = 600
    
    var allMarketCodes: [MarketCode]? {
        get {
            if let savedData = UserDefaults.standard.data(forKey: Keys.allMarketCode) {
                let decoder = PropertyListDecoder()
                if let decodedMarketCodes = try? decoder.decode([MarketCode].self, from: savedData) {
                    return decodedMarketCodes
                }
            }
            return nil
        }
    }
    
    var expiredTime: Date? {
        get {
            if let savedData = userDefaults.value(forKey: Keys.expiredTime),
               let dateData = savedData as? Date {
                return dateData
            }
            return nil
        }
        set {
            userDefaults.set(newValue, forKey: Keys.expiredTime)
            userDefaults.synchronize()
        }
        
    }
    
    func isValidAllMarketCode() -> Bool {
        guard let expiredTime = expiredTime else {
            return false
        }
        return expiredTime > Date() && allMarketCodes != nil
    }
    
    func setExpiredTime() {
        expiredTime = Calendar.current.date(byAdding: .second, value: expiredInterval, to: Date())!
    }
    
    func setAllMarketCodes(_ codes: [MarketCode]) {
        let encoder = PropertyListEncoder()
        if let encodedData = try? encoder.encode(codes) {
            UserDefaults.standard.set(encodedData, forKey: Keys.allMarketCode)
            UserDefaults.standard.synchronize()
        }
    }
}

enum NetworkServiceConfig {
    //업비트 DI Key
    static let upbitDIKey = "Upbit"
    //mockServer DI Key
    static let mockDIKey = "Mock"
}

