//
//  MarketViewModel.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import Foundation

enum MarketCoinType {
    case krw
    case usd
}

final class MarketCodeManager {

    var marketCodes: [MarketCode]?
    let apiService: APIService

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

    // 전체 마켓 코드 가져오기
    func getAllMarketCode() async throws -> [MarketCode] {
        do {
            let marketCodes = try await apiService.getAllMarketCodes()
            return marketCodes
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
}

protocol MarketDataFetcher {
    func getMarketData(marketCodes: [MarketCode]) async throws -> [MarketData]
    func getMarketData(marketCodes: [String]) async throws -> [MarketData]
    func maskMarketCode(marketCoinType: MarketCoinType, markets: [MarketCode]) -> String
}

	struct KRWMarkeData {
    let marketCoinType = MarketCoinType.krw
    let apiService: APIService
    let marketCodeManager: MarketCodeManager

    init(apiService: APIService) {
        self.apiService = apiService
        self.marketCodeManager = PurpleCoin.MarketCodeManager(apiService: apiService)
    }
}

extension KRWMarkeData: MarketDataFetcher {
    // 코인 정보 가져오기 - [MarketCode]
    func getMarketData(marketCodes: [MarketCode]) async throws -> [MarketData] {
        let maskedMarketCode = self.maskMarketCode(marketCoinType: .krw, markets: marketCodes)
        do {
            let marketData = try await apiService.getMarketData(marketCodes: maskedMarketCode)
            return marketData
        } catch {
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
            throw error
        }
    }

    func maskMarketCode(marketCoinType: MarketCoinType, markets: [MarketCode]) -> String {
        let KRWMarkets = markets.filter { market in
            market.market.contains("KRW-")
        }
        return KRWMarkets.map { $0.market }.joined(separator: ", ")
    }

    func convertArrToStr(_ strArr: [String]) -> String {
        return strArr.joined(separator: ", ")
    }
}
