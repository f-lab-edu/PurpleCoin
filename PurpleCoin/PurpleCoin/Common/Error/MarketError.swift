//
//  Error.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/29.
//

import Foundation

enum MarketError: Error {
    //마켓 코드 에러
    case marketCodeFetchingError
    //마켓 데이터 에러
    case marketDataFetchingError
    //decode 에러
    case decodingError
}
