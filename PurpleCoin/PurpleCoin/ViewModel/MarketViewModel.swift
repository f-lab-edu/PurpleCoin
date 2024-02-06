//
//  MarketViewModel.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import Foundation

final class MarketViewModel {
    var marketData: [MarketData]?
    var allMarketCode: [MarketCode]?
}

// 코인 정보 가져오기
extension MarketViewModel {
    //한국 코인 정보가져오기
    func getKRWMarketData(completion: @escaping ((MarketError?) -> Void)) {
        getAllMarketCode { result in
            switch result {
            case .success(let data):
                self.getMarketData(marketCodes: data) { result in
                    switch result {
                    case .success(let data):
                        self.marketData = data
                        completion(nil)
                    case .failure(_):
                        completion(.marketDataFetchingError)
                    }
                }
            case .failure(_):
                completion(.marketCodeFetchingError)
            }
        }
    }
    
    // 전체 마켓 코드 가져오기
    func getAllMarketCode(completion: @escaping ((Result<[MarketCode], Error>) -> Void)) {
        APIService().getAllMarketCode { result in
            completion(result)
        }
    }
    
    // 코인 정보 가져오기 - [MarketCode]
    func getMarketData(marketCodes: [MarketCode], completion: @escaping (Result<[MarketData], Error>) -> Void) {
        let convertedMarketCode = self.sortingMarketCode(markets: marketCodes)
        APIService().getMarketData(marketCodes: convertedMarketCode, completion: completion)
    }
    
    // 코인 정보 가져오기 - [String]
    func getMarketData(marketCodes: [String], completion: @escaping ((MarketError?) -> Void)) {
        let convertedMarketCode = marketCodes.joined(separator: ", ")
        print(convertedMarketCode)
        APIService().getMarketData(marketCodes: convertedMarketCode) { result in
            switch result {
            case .success(let data):
                self.marketData = data
                completion(nil)
            case .failure(_):
                completion(.marketDataFetchingError)
            }
        }
    }
    
    //KRW 코인코드 배열 -> string
    func sortingMarketCode(markets: [MarketCode]) -> String{
        let KRWMarkets = markets.filter { market in
            market.market.contains("KRW-")
        }
        allMarketCode = KRWMarkets
        return KRWMarkets.map { $0.market }.joined(separator: ", ")
    }
}
