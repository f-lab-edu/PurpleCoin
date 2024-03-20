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
    case usd
    case intrested
}
//
//final class MarketCodeManager {
//
//    var marketCodes: [MarketCode]?
//    let apiService: APIService
//
//    init(apiService: APIService) {
//        self.apiService = apiService
//    }
//
//    func searchAllMarketCode() async {
//        self.marketCodes = try? await getAllMarketCode()
//    }
//
//    func readMarketCode() async -> [MarketCode] {
//        if marketCodes == nil {
//            await searchAllMarketCode()
//        }
//        return marketCodes!
//    }
//
//    // 전체 마켓 코드 가져오기
//    func getAllMarketCode() async throws -> [MarketCode] {
//        do {
//            let marketCodes = try await apiService.getAllMarketCodes()
//            return marketCodes
//        } catch {
//            print("Error: \(error)")
//            throw error
//        }
//    }
//}
//
//protocol MarketDataFetcher {
//    func getMarketData(marketCodes: [MarketCode]) async throws -> [MarketData]
//    func maskMarketCode(marketCoinType: MarketCoinType, markets: [MarketCode]) -> String
//}
//
//struct KRWMarkeData: MarketDataFetcher {
//    let apiService: APIService
//
//    init(apiService: APIService) {
//        self.apiService = apiService
//    }
//}
//
//extension KRWMarkeData {
//    // 코인 정보 가져오기 - [MarketCode]
//    func getMarketData(marketCodes: [MarketCode]) async throws -> [MarketData] {
//        let maskedMarketCode = self.maskMarketCode(marketCoinType: .krw, markets: marketCodes)
//        do {
//            let marketData = try await apiService.getMarketData(marketCodes: maskedMarketCode)
//            return marketData
//        } catch {
//            throw error
//        }
//    }
//
//    func maskMarketCode(marketCoinType: MarketCoinType, markets: [MarketCode]) -> String {
//        let KRWMarkets = markets.filter { market in
//            market.market.contains("KRW-")
//        }
//        return KRWMarkets.map { $0.market }.joined(separator: ", ")
//    }
//}
//
//struct USDTMarkeData: MarketDataFetcher {
//    let apiService: APIService
//
//    init(apiService: APIService) {
//        self.apiService = apiService
//    }
//}
//
//extension USDTMarkeData {
//    // 코인 정보 가져오기 - [MarketCode]
//    func getMarketData(marketCodes: [MarketCode]) async throws -> [MarketData] {
//        let maskedMarketCode = self.maskMarketCode(marketCoinType: .krw, markets: marketCodes)
//        do {
//            let marketData = try await apiService.getMarketData(marketCodes: maskedMarketCode)
//            return marketData
//        } catch {
//            throw error
//        }
//    }
//
//    // 코인 정보 가져오기 - [String]
//    func getMarketData(marketCodes: [String]) async throws -> [MarketData] {
//        let convertedMarketCode = convertArrToStr(marketCodes)
//        do {
//            let marketData = try await apiService.getMarketData(marketCodes: convertedMarketCode)
//            return marketData
//        } catch {
//            throw error
//        }
//    }
//
//    func maskMarketCode(marketCoinType: MarketCoinType, markets: [MarketCode]) -> String {
//        let KRWMarkets = markets.filter { market in
//            market.market.contains("BTC-")
//        }
//        return KRWMarkets.map { $0.market }.joined(separator: ", ")
//    }
//
//    func convertArrToStr(_ strArr: [String]) -> String {
//        return strArr.joined(separator: ", ")
//    }
//}
//
//struct IntrestedMarkeData: MarketDataFetcher {
//    let apiService: APIService
//
//    init(apiService: APIService) {
//        self.apiService = apiService
//    }
//}
//
//extension IntrestedMarkeData {
//    // 코인 정보 가져오기 - [MarketCode]
//    func getMarketData(marketCodes: [MarketCode]) async throws -> [MarketData] {
//        let maskedMarketCode = self.maskMarketCode(marketCoinType: .krw, markets: marketCodes)
//        do {
//            let marketData = try await apiService.getMarketData(marketCodes: maskedMarketCode)
//            return marketData
//        } catch {
//            throw error
//        }
//    }
//
//    // 코인 정보 가져오기 - [String]
//    func getMarketData(marketCodes: [String]) async throws -> [MarketData] {
//        let convertedMarketCode = convertArrToStr(marketCodes)
//        do {
//            let marketData = try await apiService.getMarketData(marketCodes: convertedMarketCode)
//            return marketData
//        } catch {
//            throw error
//        }
//    }
//
//
//    func maskMarketCode(marketCoinType: MarketCoinType, markets: [MarketCode]) -> String {
//        let KRWMarkets = markets.filter { market in
//            market.market.contains("BTC-")
//        }
//        return KRWMarkets.map { $0.market }.joined(separator: ", ")
//    }
//
//    func convertArrToStr(_ strArr: [String]) -> String {
//        return strArr.joined(separator: ", ")
//    }
//}
//
//class MarketViewModel {
//    let apiService: APIService
//    let marketCodeManager: MarketCodeManager
//    let marketDataFetcherFactory: MarketDataFetcherFactory
//
//    init(apiService: APIService, marketCoinType: MarketCoinType) {
//        self.apiService = apiService
//        self.marketCodeManager = MarketCodeManager(apiService: apiService)
//        self.marketDataFetcherFactory = MarketDataFetcherFactory(apiService: apiService, marketCoinType: marketCoinType)
//    }
//
//    func readMarketData() async throws -> [MarketData] {
//        let marketCodes = await marketCodeManager.readMarketCode()
//        let marketDataFetcher = marketDataFetcherFactory.readMarketDataFetcher(for: )
//        return try await marketDataFetcher.getMarketData(marketCodes: marketCodes)
//    }
//}
//
//class MarketDataFetcherFactory {
//    let apiService: APIService
//    var marketDataFetcher: MarketDataFetcher?
//    var marketCoinType: MarketCoinType
//
//    init(apiService: APIService, marketCoinType: MarketCoinType) {
//        self.apiService = apiService
//        self.marketCoinType = marketCoinType
//    }
//
//    func createMarketDataFetcher(for coinType: MarketCoinType) -> MarketDataFetcher {
//        marketCoinType = coinType
//        switch coinType {
//        case .krw:
//            return KRWMarkeData(apiService: apiService)
//        case .usd:
//            return USDTMarkeData(apiService: apiService)
//        case .intrested:
//            return KRWMarkeData(apiService: apiService)
//        }
//    }
//
//    func readMarketDataFetcher(for coinType: MarketCoinType) -> MarketDataFetcher {
//        if marketDataFetcher == nil || marketCoinType != coinType {
//            return createMarketDataFetcher(for: coinType)
//        }
//        return marketDataFetcher!
//    }
//
//    func readMarketData() async throws -> [MarketData] {
//
//    }
//}


final class MarketViewModel {
    let apiService: APIService
    var marketDataManager: MarketDataManager
    
    init(apiService: APIService) {
        self.apiService = apiService
        self.marketDataManager = MarketDataManager(apiService: apiService)
    }
    
    func getMarketData() async throws -> [MarketData] {
        return try await marketDataManager.getMarketData()
    }
    
    func setCoinType(marketCoinType: MarketCoinType) {
        marketDataManager.changeCoinType(marketCoinType: marketCoinType)
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
    
    func getMarketData() async throws -> [MarketData] {
        let marketCodes = await marketCodeManager.getConvertedMarketCode()
        return try await marketDataFetcher.getMarketData(marketCodes: marketCodes)
    }
    
    func changeCoinType(marketCoinType: MarketCoinType) {
        marketCodeManager.changeCoinType(marketCoinType: marketCoinType)
    }
}

class MarketDataFetcher {
    let apiService: APIService
    
    init(apiservice: APIService) {
        self.apiService = apiservice
    }
    
    //코인 정보 가져오기 - [MarketCode]
    func getMarketData(marketCodes: String) async throws -> [MarketData] {
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
    var convertMarketCodeManager: ConvertMarketCodeManager?

    var marketCodes: [MarketCode]?

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func searchAllMarketCode() async {
        self.marketCodes = try? await getAllMarketCode()
    }

    func readMarketCode() async -> [MarketCode] {
        if marketCodes == nil {
            await searchAllMarketCode()
        }
        return marketCodes!
    }

    // 전체 마켓 코드 가져오기/
    private func getAllMarketCode() async throws -> [MarketCode] {
        do {
            let marketCodes = try await apiService.getAllMarketCodes()
            return marketCodes
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    func getConvertedMarketCode() async -> String {
        guard let convertMarketCodeManager = convertMarketCodeManager else {
            return ""
        }
        let allMarketCodes = await readMarketCode()
        return convertMarketCodeManager.getMarketCode(allMarketCodes: allMarketCodes)
    }
    
    func changeCoinType(marketCoinType: MarketCoinType) {
        switch marketCoinType {
        case .krw:
            convertMarketCodeManager = KRWMarketCode()
        case .usd:
            convertMarketCodeManager = KRWMarketCode()
        case .intrested:
            convertMarketCodeManager = KRWMarketCode()
        }
    }
}

protocol ConvertMarketCodeManager {
    func getMarketCode(allMarketCodes: [MarketCode]) -> String
}

class KRWMarketCode: ConvertMarketCodeManager {
    func getMarketCode(allMarketCodes: [MarketCode]) -> String {
        let KRWMarkets = allMarketCodes.filter { market in
            market.market.contains("KRW-")
        }
        return KRWMarkets.map { $0.market }.joined(separator: ", ")
    }
}
