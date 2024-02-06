//
//  Formatter.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/09.
//

import Foundation

final class Formatter {
    
    //소수점 두자리 끊기
    static func truncateToTwoDecimals(for number: Double) -> String {
        let truncatedString = String(format: "%.2f", number)
        return truncatedString
    }
    
    // 가격표시 포멧
    static func formatNumberWithCustomRules(for number: Double) -> String {
        var numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if checkInt(for: number) {
            numberFormatter = intFormat(for: number, with: numberFormatter)
        } else {
           numberFormatter = doubleFotmat(for: number, with: numberFormatter)
        }
        
        return formatString(for: number, with: numberFormatter)
    }
    
    // 최종 넘머 포멧 적용
    static func formatString(for number: Double, with numberFormatter: NumberFormatter) -> String {
        if let formattedString = numberFormatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            return "\(number)" // 포맷팅 실패 시, 기본 문자열 반환
        }
    }
    
    //Int 넘버 포멧
    static func intFormat(for number: Double, with numberFormatter: NumberFormatter) -> NumberFormatter {
        if checkLargeInt(for: number) { // 3자리 수 이상인 정수 -> 그대로 표현
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 0
        } else if checkSmallInt(for: number) { // 1자리 수 정수-> 뒤에 소수점(.00) 붙여서 표현
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        }
        return numberFormatter
    }
    
    //Double 넘버 포멧
    static func doubleFotmat(for number: Double, with numberFormatter: NumberFormatter) -> NumberFormatter {
        if checkOneDecimal(for: number) { // 실수인데 소수점이 한자리인 경우 -> 소수점 두자리로 표현
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        } else { // 실수인데 소수점이 두자리이상인 경우 -> 그대로 표현
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = Int.max
        }
        return numberFormatter
    }
    
    // 정수형인지 체크
    static func checkInt(for number: Double) -> Bool {
        return number.truncatingRemainder(dividingBy: 1) == 0
    }
    
    // 절대값이 100이상인지 체크
    static func checkLargeInt(for number: Double) -> Bool {
        let absoluteValue = abs(number)
        return absoluteValue >= 100
    }
    
    // 절대값이 10이상인지 체크
    static func checkSmallInt(for number: Double) -> Bool {
        let absoluteValue = abs(number)
        return absoluteValue < 10
    }
    
    // 소수점 한자리인지 체크
    static func checkOneDecimal(for number: Double) -> Bool {
        return String(number).split(separator: ".").last?.count ?? 0 <= 1
    }
    
    //백만 단위 포멧
    static func formatToMillionUnit(for number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let million = 1000000
        let dividedNumber = Int(Double(number) / Double(million))
        let formattedNumber = formatter.string(from: NSNumber(value: dividedNumber)) ?? "\(number)"
        
        return "\(formattedNumber)백만"
    }
    
    // KRW-CoinName ->  CoinName/KRW
    static func convertEngCoinName(_ name: String) -> String{
        let components = name.components(separatedBy: "-")
        if components.count == 2 {
            let convertedName = "\(components[1])/\(components[0])"
            return convertedName
        } else {
            return name
        }
    }
}
