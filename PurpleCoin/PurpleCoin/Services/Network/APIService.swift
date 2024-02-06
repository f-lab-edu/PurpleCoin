//
//  APIService.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import UIKit
import Moya
import Combine

final class APIService {
    let provider  = MoyaProvider<API>()
    
    // 전체 코인코드 가져오기
    func getAllMarketCode(completion: @escaping (Result<[MarketCode], Error>) -> Void) {
        request(target: .getAllMarketCode, completion: completion)
    }
    
    //특정 코인 정보들 가져오기
    func getMarketData(marketCodes: String ,completion: @escaping (Result<[MarketData], Error>) -> Void) {
        request(target: .getMarketInfo(marketCodes: marketCodes), completion: completion)
    }
    
    //호가 정보 가져오기
    func getOrderBookDataPublisher(marketCodes: String) -> AnyPublisher<[OrderBook], OrderBookError> {
        return Future<[OrderBook], OrderBookError> { promise in
            self.provider.request(.getOrderBook(marketCodes: marketCodes)) { result in
                switch result {
                case .success(let response):
                    do {
                        let results = try JSONDecoder().decode([OrderBook].self, from: response.data)
                        promise(.success(results))
                    } catch _ as DecodingError {
                        promise(.failure(.decodingError))
                    } catch _ {
                        promise(.failure(.orderBookFetchingError))
                    }
                case .failure(_):
                    promise(.failure(.orderBookFetchingError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

private extension APIService {
    
    func request<T: Decodable>(target: API,
                               completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
//    func request<T: Decodable, U: Error>(target: API,
//                               decoder: T,
//                               errorType: U
//    ) -> AnyPublisher<T, U> {
//        return
//    }
}
