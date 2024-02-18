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
    func getAllMarketCodes() async throws -> [MarketCode]
    //특정 코인 정보들 가져오기
    func getMarketData(marketCodes: String) async throws -> [MarketData]
    //호가 정보 가져오기
    func getOrderBookData(marketCodes: String) async throws -> [OrderBook]
}

final class UpbitService: APIService {
    
    var provider = MoyaProvider<API>()
    
    //전체 마켓 코드 가져오기
    func getAllMarketCodes() async throws -> [MarketCode] {
        let networkConfig = NetworkConfig.shared
        if networkConfig.isValidAllMarketCode() {
            return networkConfig.allMarketCodes!
        }
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getAllMarketCode) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode([MarketCode].self, from: response.data)
                        self.cacheAllMarketCodes(results)
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
    
    func cacheAllMarketCodes(_ markedCodes: [MarketCode]) {
        let networkConfig = NetworkConfig.shared
        networkConfig.setExpiredTime()
        networkConfig.setAllMarketCodes(markedCodes)
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
    
    //호가 정보 가져오기
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

extension UpbitService {
    
}
