//
//  CoinInformationView.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/23.
//

import UIKit

class CoinInformationView: UIView {
    
    private enum Font {
        static let priceLabelFont = PurpleCoinFont.font(type: .regular, size: 16)
    }
    
    let coinPriceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.priceLabelFont
        return label
    }()
    let coinDTDLabel: UILabel = {
        let label = UILabel()
        label.font = Font.priceLabelFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = PurpleCoinColor.pointColor
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Layout
extension CoinInformationView {
    func setLayout() {
        [coinPriceLabel, coinDTDLabel].forEach {
            addSubview($0)
        }
        coinPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10 * ScreenFigure.Ratio.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
        }
        coinDTDLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
            $0.top.equalTo(coinPriceLabel.snp.bottom).offset(4 * ScreenFigure.Ratio.VRatioValue)
            $0.bottom.equalToSuperview().inset(10 * ScreenFigure.Ratio.VRatioValue)
        }
    }
}
