//
//  Market.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

struct MarketCode: Codable {
    let englishName: String
    let koreanName: String
    let market: String
    
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case koreanName = "korean_name"
        case market
    }
}

struct MarketData: Codable {
    // API Reference https://docs.upbit.com/reference/ticker%ED%98%84%EC%9E%AC%EA%B0%80-%EC%A0%95%EB%B3%B4
    let market: String
    let tradeDate: String
    let tradeTime: String
    let tradeDateKST: String
    let tradeTimeKST: String
    let tradeTimestamp: Int
    let openingPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let tradePrice: Double
    let prevClosingPrice: Double
    let change: String
    let changePrice: Double
    let changeRate: Double
    let signedChangePrice: Double
    let signedChangeRate: Double
    let tradeVolume: Double
    let accTradePrice: Double
    let accTradePrice24h: Double
    let accTradeVolume: Double
    let accTradeVolume24h: Double
    let highest52WeekPrice: Double
    let highest52WeekDate: String
    let lowest52WeekPrice: Double
    let lowest52WeekDate: String
    let timestamp: Int
    
    private enum CodingKeys: String, CodingKey {
        case market
        case tradeDate = "trade_date"
        case tradeTime = "trade_time"
        case tradeDateKST = "trade_date_kst"
        case tradeTimeKST = "trade_time_kst"
        case tradeTimestamp = "trade_timestamp"
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case change
        case changePrice = "change_price"
        case changeRate = "change_rate"
        case signedChangePrice = "signed_change_price"
        case signedChangeRate = "signed_change_rate"
        case tradeVolume = "trade_volume"
        case accTradePrice = "acc_trade_price"
        case accTradePrice24h = "acc_trade_price_24h"
        case accTradeVolume = "acc_trade_volume"
        case accTradeVolume24h = "acc_trade_volume_24h"
        case highest52WeekPrice = "highest_52_week_price"
        case highest52WeekDate = "highest_52_week_date"
        case lowest52WeekPrice = "lowest_52_week_price"
        case lowest52WeekDate = "lowest_52_week_date"
        case timestamp
    }
}
