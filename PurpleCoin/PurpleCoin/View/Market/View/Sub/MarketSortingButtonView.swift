//
//  MarketSortingButtonView.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/23.
//

import UIKit

class MarketSortingButtonView: UIView {
    
    private enum Font {
        static let sortingButtonFont = PurpleCoinFont.font(type: .semibold, size: 13)
    }
    
    let sortingOfAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체(KRW)", for: .normal)
        button.setTitleColor(PurpleCoinColor.selectColor, for: .normal)
        button.titleLabel?.font = Font.sortingButtonFont
        button.layer.borderColor = PurpleCoinColor.selectColor.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    let sortingOfIntrestButton: UIButton = {
        let button = UIButton()
        button.setTitle("관심", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Font.sortingButtonFont
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
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
extension MarketSortingButtonView {
    func setLayout() {
        [sortingOfAllButton, sortingOfIntrestButton].forEach {
            addSubview($0)
        }
        sortingOfAllButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(7 * ScreenFigure.Ratio.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
            $0.width.equalTo(85 * ScreenFigure.Ratio.HRatioValue)
            $0.height.equalTo(27 * ScreenFigure.Ratio.VRatioValue)
        }
        sortingOfIntrestButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(7 * ScreenFigure.Ratio.VRatioValue)
            $0.left.equalTo(sortingOfAllButton.snp.right).offset(17 * ScreenFigure.Ratio.HRatioValue)
            $0.width.equalTo(48 * ScreenFigure.Ratio.HRatioValue)
            $0.height.equalTo(27 * ScreenFigure.Ratio.VRatioValue)
        }
    }
}
