//
//  MarketCodeError.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/02/09.
//

import Foundation

enum MarketCodeError: Error {
    //호가 정보 에러
    case marketCodeFetchingError
    //decode 에러
    case decodingError
}
