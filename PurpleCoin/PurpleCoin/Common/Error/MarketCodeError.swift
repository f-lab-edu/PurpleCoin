//
//  MarketCodeError.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/02/09.
//

import Foundation

enum MarketCodeError: Error, ErrorHandler {
    // 호가 정보 에러
    case marketCodeFetchingError
    // decode 에러
    case decodingError
    
    func getErrorWarning() -> String{
        switch self {
        case .marketCodeFetchingError:
            return "마켓 코드 패치 에러\n새로고침 해주세요"
        case .decodingError:
            return "디코딩 에러\n새로고침 해주세요"
        }
    }
}
