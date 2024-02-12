//
//  MarketViewModel.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import Foundation

final class MarketViewModel {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
}

// 코인 정보 가져오기
extension MarketViewModel {
    
    // 전체 마켓 코드 가져오기
    func getAllMarketCode() async throws -> [MarketCode] {
        do {
            let marketCodes = try await apiService.getAllMarketCode()
            return marketCodes
        } catch {
            print("Error: \(error)")
            throw error
        }

    }
    
    // 코인 정보 가져오기 - [MarketCode]
    func getMarketData(marketCodes: [MarketCode]) async throws -> [MarketData] {
        let maskedMarketCode = self.maskKRWMarketCode(markets: marketCodes)
        do {
            let marketData = try await apiService.getMarketData(marketCodes: maskedMarketCode)
            return marketData
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    // 코인 정보 가져오기 - [String]
    func getMarketData(marketCodes: [String]) async throws -> [MarketData] {
        let convertedMarketCode = convertArrToStr(marketCodes)
        do {
            let marketData = try await apiService.getMarketData(marketCodes: convertedMarketCode)
            return marketData
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    //KRW 코인코드 배열 -> string
    func maskKRWMarketCode(markets: [MarketCode]) -> String {
        let KRWMarkets = markets.filter { market in
            market.market.contains("KRW-")
        }
        return KRWMarkets.map { $0.market }.joined(separator: ", ")
    }
    
    func convertArrToStr(_ strArr: [String]) -> String{
        return strArr.joined(separator: ", ")
    }
}
