//
//  CoinTableViewCell.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2023/12/24.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    // 코인 이름 - 한국 
    let koreanCoinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "도지코인"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let englishCoinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "DOGE/KRW"
        label.textColor = PurpleCoinColor.gray
        label.font = PurpleCoinFont.font(type: .medium, size: 10)
        return label
    }()
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "135"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let percentageComparedPreviousDayLabel: UILabel = {
        let label = UILabel()
        label.text = "11.89"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let priceComparedPreviousDayLabel: UILabel = {
        let label = UILabel()
        label.text = "11.89"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let transactionPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "316,101백만"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = PurpleCoinColor.darkPointColor
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        [koreanCoinNameLabel, englishCoinNameLabel, currentPriceLabel, percentageComparedPreviousDayLabel, priceComparedPreviousDayLabel, transactionPriceLabel].forEach {
            contentView.addSubview($0)
        }
        koreanCoinNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10 * ScreenFigure.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
        englishCoinNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.bottom.equalToSuperview().inset(10 * ScreenFigure.VRatioValue)
        }
        currentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(koreanCoinNameLabel)
            $0.right.equalToSuperview().inset(150 * ScreenFigure.HRatioValue)
        }
        percentageComparedPreviousDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(koreanCoinNameLabel)
            $0.right.equalToSuperview().inset(92 * ScreenFigure.HRatioValue)
        }
        priceComparedPreviousDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(englishCoinNameLabel)
            $0.right.equalTo(percentageComparedPreviousDayLabel)
        }
        transactionPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(koreanCoinNameLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
    }
}
