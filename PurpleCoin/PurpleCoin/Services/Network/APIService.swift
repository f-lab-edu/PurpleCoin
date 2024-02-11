//
//  APIService.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import UIKit
import Moya
import Combine

protocol APIService {
    // 전체 코인코드 가져오기
    func getAllMarketCode() async throws -> [MarketCode]
    //특정 코인 정보들 가져오기
    func getMarketData(marketCodes: String) async throws -> [MarketData]
    //호가 정보 가져오기
    func getOrderBookData(marketCodes: String) async throws -> [OrderBook]
}

final class UpbitService: APIService {
    
    var provider = MoyaProvider<API>()
    
    //특정 코인 정보들 가져오기
    func getAllMarketCode() async throws -> [MarketCode] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getAllMarketCode) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode([MarketCode].self, from: response.data)
                        continuation.resume(returning: results)
                    } catch {
                        continuation.resume(throwing: MarketCodeError.decodingError)
                    }
                case .failure(_):
                    continuation.resume(throwing: MarketCodeError.marketCodeFetchingError)
                }
            }
        }
    }
    
    //특정 코인 정보들 가져오기
    func getMarketData(marketCodes: String) async throws -> [MarketData] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getMarketInfo(marketCodes: marketCodes)) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode([MarketData].self, from: response.data)
                        continuation.resume(returning: results)
                    } catch {
                        continuation.resume(throwing: MarketError.decodingError)
                    }
                case .failure(_):
                    continuation.resume(throwing: MarketError.marketDataFetchingError)
                }
            }
        }
    }
    
    func getOrderBookData(marketCodes: String) async throws -> [OrderBook] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getOrderBook(marketCodes: marketCodes)) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode([OrderBook].self, from: response.data)
                        continuation.resume(returning: results)
                    } catch {
                        continuation.resume(throwing: OrderBookError.decodingError)
                    }
                case .failure(_):
                    continuation.resume(throwing: OrderBookError.orderBookFetchingError)
                }
            }
        }
    }
}
