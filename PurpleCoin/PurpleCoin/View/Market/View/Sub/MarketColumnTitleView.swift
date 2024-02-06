//
//  MarketColumnTitleView.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/23.
//

import UIKit

class MarketColumnTitleView: UIView {
    
    private enum Font {
        static let cloumnTitleLabelFont = PurpleCoinFont.font(type: .semibold, size: 11)
    }
    
    let columnTopLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let coinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "코인명"
        label.textColor = .white
        label.font = Font.cloumnTitleLabelFont
        return label
    }()
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "현재가"
        label.textColor = .white
        label.font = Font.cloumnTitleLabelFont
        return label
    }()
    let dtdPercentLabel: UILabel = {
        let label = UILabel()
        label.text = "전일대비"
        label.textColor = .white
        label.font = Font.cloumnTitleLabelFont
        return label
    }()
    let transactionPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "거래대금"
        label.textColor = .white
        label.font = Font.cloumnTitleLabelFont
        return label
    }()
    let columnBottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = PurpleCoinColor.darkPointColor
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Layout
extension MarketColumnTitleView {
    func setLayout() {
        [columnTopLineView, coinNameLabel, currentPriceLabel, dtdPercentLabel, transactionPriceLabel, columnBottomLineView].forEach {
            addSubview($0)
        }
        columnTopLineView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        coinNameLabel.snp.makeConstraints {
            $0.top.equalTo(columnTopLineView.snp.bottom).offset(5 * ScreenFigure.Ratio.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
            $0.bottom.equalTo(columnBottomLineView.snp.bottom).offset(-5 * ScreenFigure.Ratio.VRatioValue)
        }
        currentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(coinNameLabel)
            $0.right.equalTo(dtdPercentLabel.snp.left).offset(-19 * ScreenFigure.Ratio.HRatioValue)
        }
        dtdPercentLabel.snp.makeConstraints {
            $0.centerY.equalTo(coinNameLabel)
            $0.right.equalTo(transactionPriceLabel.snp.left).offset(-41 * ScreenFigure.Ratio.HRatioValue)
        }
        transactionPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(coinNameLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
        }
        columnBottomLineView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
