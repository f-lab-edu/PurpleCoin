//
//  OrderBookErro.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/29.
//

import Foundation
enum OrderBookError: Error {
    //호가 정보 에러
    case orderBookFetchingError
    //decode 에러
    case decodingError
}
