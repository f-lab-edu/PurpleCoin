//
//  TopView.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/23.
//

import UIKit

class DetailCoinTopView: UIView {
    
    private enum Font {
        static let topTitleLabelFont = PurpleCoinFont.font(type: .bold, size: 20)
    }
    
    private enum Metric {
        static let backButtonSize = CGSize(width: 30 * ScreenFigure.Ratio.VRatioValue, height: 30 * ScreenFigure.Ratio.VRatioValue)
        static let intrestButtonSize = CGSize(width: 20 * ScreenFigure.Ratio.VRatioValue, height: 20 * ScreenFigure.Ratio.VRatioValue)
    }
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도지코인"
        label.textColor = .white
        label.font = Font.topTitleLabelFont
        return label
    }()
    let interestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "star"), for: .normal)
        button.setImage(UIImage(named: "star_filled"), for: .selected)
        return button
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
extension DetailCoinTopView {
    func setLayout() {
        [backButton, topTitleLabel, interestButton].forEach {
            addSubview($0)
        }
        backButton.snp.makeConstraints {
            $0.centerY.equalTo(topTitleLabel)
            $0.left.equalToSuperview().inset(7 * ScreenFigure.Ratio.HRatioValue)
            $0.size.equalTo(Metric.backButtonSize)
        }
        topTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(62 - ScreenFigure.notchHeight())
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25 * ScreenFigure.Ratio.VRatioValue)
        }
        interestButton.snp.makeConstraints {
            $0.centerY.equalTo(topTitleLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
            $0.size.equalTo(Metric.intrestButtonSize)
        }
    }
}
