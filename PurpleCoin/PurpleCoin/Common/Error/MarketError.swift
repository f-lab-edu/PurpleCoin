//
//  Error.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/29.
//

import Foundation

enum MarketError: Error, ErrorHandler {
    // 마켓 코드 에러
    case marketCodeFetchingError
    // 마켓 데이터 에러
    case marketDataFetchingError
    // decode 에러
    case decodingError
    
    func getErrorWarning() -> String{
        switch self {
        case .marketCodeFetchingError:
            return "마켓 코드 패치 에러\n새로고침 해주세요"
        case .marketDataFetchingError:
            return "마켓 데이터 패치 에러\n새로고침 해주세요"
        case .decodingError:
            return "디코딩 에러\n새로고침 해주세요"
        }
    }
}
