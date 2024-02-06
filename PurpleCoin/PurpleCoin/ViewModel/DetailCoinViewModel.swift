//
//  DetailCoinViewModel.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2024/01/12.
//

import UIKit
import Combine

final class DetailCoinViewModel {
    var marketData: MarketData?
    var orderBookData: OrderBook?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getMarketData(marketCode: String, completion: @escaping (Result<[MarketData], Error>) -> Void) {
        APIService().getMarketData(marketCodes: marketCode) { result in
            switch result {
            case .success(let data):
                self.marketData = data[0]
                completion(result)
            case .failure(let err):
                print(err)
                self.marketData = nil
                completion(result)
            }
        }
    }
    
    func getOrderBookData(marketCode: String, completion: @escaping (OrderBookError?) -> Void) {
        APIService().getOrderBookDataPublisher(marketCodes: marketCode)
            .sink { sinkCompletion in
                switch sinkCompletion {
                case .finished:
                    completion(nil)
                case .failure(let err):
                    completion(err)
                }
            } receiveValue: { orderBook in
                self.orderBookData = orderBook.first
            }
            .store(in: &cancellables)
    }

//    func getOrderBookData(marketCode: String) async throws -> OrderBookError? {
//        do {
//            APIService().getOrderBookDataPublisher(marketCodes: marketCode)
//                .sink { sinkCompletion in
//                    switch sinkCompletion {
//                    case .finished:
//                        throw nil
//                    case .failure(let err):
//                        throw err
//                    }
//                } receiveValue: { orderBook in
//                    self.orderBookData = orderBook.first
//                }
//                .store(in: &cancellables)
//        } catch {
//            throw error
//        }
//    }
}
