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

struct DetailCoinData {
    let apiService: APIService
}

extension DetailCoinData: DetailMarketDataFetcher {
    func getMarketData(marketCode: String) async throws -> MarketData {
        do {
            let marketData = try await apiService.getMarketData(marketCodes: marketCode)
            return marketData.first!
        } catch {
            throw error
        }
    }
}

extension DetailCoinData: OrderBookDataFetcher {
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
