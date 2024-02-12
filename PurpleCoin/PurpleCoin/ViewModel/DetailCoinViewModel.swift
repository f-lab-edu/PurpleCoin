//
//  DetailCoinViewModel.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2024/01/12.
//

import UIKit
import Combine

final class DetailCoinViewModel {
    
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
}

extension DetailCoinViewModel {
    func getMarketData(marketCode: String) async throws -> MarketData {
        do {
            let marketData = try await apiService.getMarketData(marketCodes: marketCode)
            return marketData.first!
        } catch {
            print("Error: \(error)")
            throw error
        }
    }

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
