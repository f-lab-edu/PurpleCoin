//
//  MarketValuationView.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/23.
//

import UIKit

class MarketValuationView: UIView {
    
    private enum Font {
        static let valuationLabelFont = PurpleCoinFont.font(type: .medium, size: 12)
        static let sortingButtonFont = PurpleCoinFont.font(type: .semibold, size: 13)
        static let cloumnTitleLabelFont = PurpleCoinFont.font(type: .semibold, size: 11)
    }
    
    let totalPurchaseTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 매수"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    let totalPurchaseContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    let totalEvaluationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 평가"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    let totalEvaluationContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    let valuationGainOrLossTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "평가손익"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    let valuationGainOrLossContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    let rateOfReturnTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "수익률"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    let rateOfReturnContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = Font.valuationLabelFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = PurpleCoinColor.lightPointColor
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Layout
extension MarketValuationView {
    func setLayout() {
        [
            totalPurchaseTitleLabel,totalPurchaseContentLabel,
            totalEvaluationTitleLabel, totalEvaluationContentLabel,
            valuationGainOrLossTitleLabel, valuationGainOrLossContentLabel,
            rateOfReturnTitleLabel, rateOfReturnContentLabel
        ].forEach {
            addSubview($0)
        }
        totalPurchaseTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12 * ScreenFigure.Ratio.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
        }
        totalPurchaseContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalPurchaseTitleLabel)
            $0.right.equalTo(self.snp.centerX).offset(-8 * ScreenFigure.Ratio.HRatioValue)
        }
        totalEvaluationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(totalPurchaseTitleLabel.snp.bottom).offset(12 * ScreenFigure.Ratio.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
            $0.bottom.equalToSuperview().inset(12 * ScreenFigure.Ratio.VRatioValue)
        }
        totalEvaluationContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalEvaluationTitleLabel)
            $0.right.equalTo(self.snp.centerX).offset(-8 * ScreenFigure.Ratio.HRatioValue)
        }
        valuationGainOrLossTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalPurchaseTitleLabel)
            $0.left.equalTo(self.snp.centerX).offset(8 * ScreenFigure.Ratio.HRatioValue)
        }
        valuationGainOrLossContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(valuationGainOrLossTitleLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
        }
        rateOfReturnTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalEvaluationTitleLabel)
            $0.left.equalTo(valuationGainOrLossTitleLabel)
        }
        rateOfReturnContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(rateOfReturnTitleLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
        }
    }
}
