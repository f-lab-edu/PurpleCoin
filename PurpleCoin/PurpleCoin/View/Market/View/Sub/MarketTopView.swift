//
//  MarketTopView.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/23.
//

import UIKit

class MarketTopView: UIView {
    
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "거래소"
        label.font = PurpleCoinFont.font(type: .bold, size: 20)
        label.textColor = .white
        return label
    }()
    
    //MARK: searchSection
    lazy var searchView: UIView = {
        let view = UIView()
        return view
    }()
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        return imageView
    }()
    let serachTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = PurpleCoinFont.font(type: .semibold, size: 13)
        textField.attributedPlaceholder =  NSAttributedString(string: "코인명 검색", attributes: [
            NSAttributedString.Key.font: PurpleCoinFont.font(type: .semibold, size: 13),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        return textField
    }()
    let searchLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
extension MarketTopView {
    func setLayout() {
        setSearchView()
        [topTitleLabel, searchView].forEach {
            addSubview($0)
        }
        topTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(62 - ScreenFigure.notchHeight())
            $0.centerX.equalToSuperview()
        }
        searchView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(21 * ScreenFigure.Ratio.VRatioValue)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25 * ScreenFigure.Ratio.VRatioValue)
        }
    }
    
    func setSearchView() {
        [searchImageView, serachTextField, searchLineView].forEach {
            searchView.addSubview($0)
        }
        searchImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
            $0.width.height.equalTo(20 * ScreenFigure.Ratio.HRatioValue)
        }
        serachTextField.snp.makeConstraints {
            $0.left.equalTo(searchImageView.snp.right).offset(10 * ScreenFigure.Ratio.HRatioValue)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.Ratio.HRatioValue)
            $0.centerY.equalTo(searchImageView)
        }
        searchLineView.snp.makeConstraints {
            $0.top.equalTo(searchImageView.snp.bottom).offset(6 * ScreenFigure.Ratio.VRatioValue)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(3 * ScreenFigure.Ratio.VRatioValue)
        }
    }
}
