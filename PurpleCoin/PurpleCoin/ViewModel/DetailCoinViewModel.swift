//
//  DetailCoinViewModel.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2024/01/12.
//

import UIKit
import Combine

protocol OrderBookDataFetcher {
    func getOrderBookData(marketCode: String) async throws -> OrderBook
}

protocol DetailMarketDataFetcher {
    func getMarketData(marketCode: String) async throws -> MarketData
}

class DetailCoinDataManager {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
}

extension DetailCoinDataManager: DetailMarketDataFetcher {
    func getMarketData(marketCode: String) async throws -> MarketData {
        do {
            let marketData = try await apiService.getMarketData(marketCodes: marketCode)
            return marketData.first!
        } catch {
            throw error
        }
    }
}

extension DetailCoinDataManager: OrderBookDataFetcher {
    func getOrderBookData(marketCode: String) async throws -> OrderBook {
        do {
            let orderBookData = try await apiService.getOrderBookData(marketCodes: marketCode)
            return orderBookData.first!
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
}

final class DetailCoinViewModel {
    let detailMarketDataFetcher: DetailMarketDataFetcher
    let orderBookDataFetcher: OrderBookDataFetcher
    
    init(apiService: APIService) {
        self.detailMarketDataFetcher = DetailCoinDataManager(apiService: apiService)
        self.orderBookDataFetcher = DetailCoinDataManager(apiService: apiService)
    }
    
    func getMarketData(marketCode: String) async throws -> MarketData {
        return try await detailMarketDataFetcher.getMarketData(marketCode: marketCode)
    }
    
    func getOrderBookData(marketCode: String) async throws -> OrderBook {
        return try await orderBookDataFetcher.getOrderBookData(marketCode: marketCode)
    }
}
