//
//  MarketViewModel.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import Foundation
//
enum MarketCoinType {
    case krw
    case btc
    case intrested
}
final class MarketViewModel {
    let apiService: APIService
    var marketDataManager: MarketDataManager
    
    init(apiService: APIService) {
        self.apiService = apiService
        self.marketDataManager = MarketDataManager(apiService: apiService)
    }
    
    func fetchMarketData() async throws -> [MarketData] {
        return try await marketDataManager.fetchMarketData()
    }
    
    func setCoinType(marketCoinType: MarketCoinType) {
        marketDataManager.setCoinType(marketCoinType: marketCoinType)
    }
}

final class MarketDataManager {
    
    let apiService: APIService
    let marketDataFetcher: MarketDataFetcher
    var marketCodeManager: MarketCodeManager
    
    init(apiService: APIService) {
        self.apiService = apiService
        self.marketDataFetcher = MarketDataFetcher(apiservice: apiService)
        self.marketCodeManager = MarketCodeManager(apiService: apiService)
    }
    
    func fetchMarketData() async throws -> [MarketData] {
        let marketCodes = try await retrieveSpecificMarketCode()
        return try await marketDataFetcher.fetchMarketData(marketCodes: marketCodes)
    }
    
    private func retrieveSpecificMarketCode() async throws -> String{
        return try await marketCodeManager.retrieveSpecificMarketCode()
    }
    
    func setCoinType(marketCoinType: MarketCoinType) {
        marketCodeManager.changeMarketCoinType(to: marketCoinType)
    }
}

final class MarketDataFetcher {
    let apiService: APIService
    
    init(apiservice: APIService) {
        self.apiService = apiservice
    }
    
    //코인 정보 가져오기 - [MarketCode]
    func fetchMarketData(marketCodes: String) async throws -> [MarketData] {
        do {
            let marketData = try await apiService.getMarketData(marketCodes: marketCodes)
            return marketData
        } catch {
            throw error
        }
    }
}

final class MarketCodeManager {
    
    let apiService: APIService
    var specificMarketCode: SpecificMarketCode?

    var marketCodes: [MarketCode]?

    init(apiService: APIService) {
        self.apiService = apiService
    }

    private func setAllMarketCode() async {
        self.marketCodes = try? await fetchAllMarketCode()
    }

    private func readAllMarketCodes() async -> [MarketCode] {
        if marketCodes == nil {
            await setAllMarketCode()
        }
        return marketCodes!
    }

    // 전체 마켓 코드 가져오기
    private func fetchAllMarketCode() async throws -> [MarketCode] {
        do {
            let marketCodes = try await apiService.getAllMarketCodes()
            return marketCodes
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    func retrieveSpecificMarketCode() async throws-> String {
        guard let convertMarketCodeManager = specificMarketCode else {
            throw MarketError.marketDataFetchingError
        }
        let allMarketCodes = await readAllMarketCodes()
        return convertMarketCodeManager.convertMarketCodes(allMarketCodes: allMarketCodes)
    }
    
    func changeMarketCoinType(to marketCoinType: MarketCoinType) {
        switch marketCoinType {
        case .krw:
            specificMarketCode = KRWMarketCode()
        case .btc:
            specificMarketCode = BTCMarketCode()
        case .intrested:
            specificMarketCode = IntrestedMarketCode()
        }
    }
}

protocol SpecificMarketCode {
    func convertMarketCodes(allMarketCodes: [MarketCode]) -> String
}

final class KRWMarketCode: SpecificMarketCode {
    func convertMarketCodes(allMarketCodes: [MarketCode]) -> String {
        let KRWMarkets = allMarketCodes.filter { market in
            market.market.contains("KRW-")
        }
        return KRWMarkets.map { $0.market }.joined(separator: ", ")
    }
}

final class BTCMarketCode: SpecificMarketCode {
    func convertMarketCodes(allMarketCodes: [MarketCode]) -> String {
        let BTCMarkets = allMarketCodes.filter { market in
            market.market.contains("BTC-")
        }
        return BTCMarkets.map { $0.market }.joined(separator: ", ")
    }
}

final class IntrestedMarketCode: SpecificMarketCode {
    func convertMarketCodes(allMarketCodes: [MarketCode]) -> String {
        return UserConfig.shared.intrestedCoins.joined(separator: ", ")
    }
}
