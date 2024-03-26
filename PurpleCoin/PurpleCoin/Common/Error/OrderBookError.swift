//
//  OrderBookErro.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/29.
//

import Foundation

enum OrderBookError: Error, ErrorHandler {
    // 호가 정보 에러
    case orderBookFetchingError
    // decode 에러
    case decodingError
    
    func getErrorWarning() -> String{
        switch self {
        case .orderBookFetchingError:
            return "마켓 코드 패치 에러\n새로고침 해주세요"
        case .decodingError:
            return "디코딩 에러\n새로고침 해주세요"
        }
    }
}
