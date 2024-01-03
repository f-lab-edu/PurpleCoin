//
//  MarketView.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class MarketView: UIView {
    
    //MARK: topView
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = PurpleCoinColor.pointColor
        [topTitleLabel, searchView].forEach {
            view.addSubview($0)
        }
        topTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(62 - ScreenFigure.notchHeight())
            $0.centerX.equalToSuperview()
        }
        searchView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(21 * ScreenFigure.VRatioValue)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25 * ScreenFigure.VRatioValue)
        }
        return view
    }()
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "거래소"
        label.font = PurpleCoinFont.font(type: .bold, size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var searchView: UIView = {
        let view = UIView()
        [searchImageView, serachTextField, searchLineView].forEach {
            view.addSubview($0)
        }
        searchImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.width.height.equalTo(20 * ScreenFigure.HRatioValue)
        }
        serachTextField.snp.makeConstraints {
            $0.left.equalTo(searchImageView.snp.right).offset(10 * ScreenFigure.HRatioValue)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.centerY.equalTo(searchImageView)
        }
        searchLineView.snp.makeConstraints {
            $0.top.equalTo(searchImageView.snp.bottom).offset(6 * ScreenFigure.VRatioValue)
            
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(3 * ScreenFigure.VRatioValue)
        }
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
    //MARK: valuationView
    lazy var valuationView: UIView = {
        let view = UIView()
        view.backgroundColor = PurpleCoinColor.lightPointColor
        [
            totalPurchaseTitleLabel,totalPurchaseContentLabel,
            totalEvaluationTitleLabel, totalEvaluationContentLabel,
            valuationGainOrLossTitleLabel, valuationGainOrLossContentLabel,
            rateOfReturnTitleLabel, rateOfReturnContentLabel
        ].forEach {
            view.addSubview($0)
        }
        totalPurchaseTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12 * ScreenFigure.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
        totalPurchaseContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalPurchaseTitleLabel)
            $0.right.equalTo(view.snp.centerX).offset(-8 * ScreenFigure.HRatioValue)
        }
        totalEvaluationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(totalPurchaseTitleLabel.snp.bottom).offset(12 * ScreenFigure.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.bottom.equalToSuperview().inset(12 * ScreenFigure.VRatioValue)
        }
        totalEvaluationContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalEvaluationTitleLabel)
            $0.right.equalTo(view.snp.centerX).offset(-8 * ScreenFigure.HRatioValue)
        }
        valuationGainOrLossTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalPurchaseTitleLabel)
            $0.left.equalTo(view.snp.centerX).offset(8 * ScreenFigure.HRatioValue)
        }
        valuationGainOrLossContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(valuationGainOrLossTitleLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
        rateOfReturnTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalEvaluationTitleLabel)
            $0.left.equalTo(valuationGainOrLossTitleLabel)
        }
        rateOfReturnContentLabel.snp.makeConstraints {
            $0.centerY.equalTo(rateOfReturnTitleLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
        return view
    }()
    let totalPurchaseTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 매수"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let totalPurchaseContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let totalEvaluationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 평가"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let totalEvaluationContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let valuationGainOrLossTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "평가손익"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let valuationGainOrLossContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let rateOfReturnTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "수익률"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    let rateOfReturnContentLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .medium, size: 12)
        return label
    }()
    
    //MARK: sortingButtonView
    lazy var sortingButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = PurpleCoinColor.darkPointColor
        [sortingOfAllButton, sortingOfIntrestButton].forEach {
            view.addSubview($0)
        }
        sortingOfAllButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(7 * ScreenFigure.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.width.equalTo(85 * ScreenFigure.HRatioValue)
            $0.height.equalTo(27 * ScreenFigure.VRatioValue)
        }
        sortingOfIntrestButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(7 * ScreenFigure.VRatioValue)
            $0.left.equalTo(sortingOfAllButton.snp.right).offset(17 * ScreenFigure.HRatioValue)
            $0.width.equalTo(48 * ScreenFigure.HRatioValue)
            $0.height.equalTo(27 * ScreenFigure.VRatioValue)
        }
        return view
    }()
    let sortingOfAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체(KRW)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(PurpleCoinColor.selectColor, for: .selected)
        button.titleLabel?.font = PurpleCoinFont.font(type: .semibold, size: 13)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    let sortingOfIntrestButton: UIButton = {
        let button = UIButton()
        button.setTitle("관심", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(PurpleCoinColor.selectColor, for: .selected)
        button.titleLabel?.font = PurpleCoinFont.font(type: .semibold, size: 13)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    //MARK: columnTitleView
    lazy var columnTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = PurpleCoinColor.darkPointColor
        [columnTopLineView, coinNameLabel, currentPriceLabel, percentOfPreviousDayLabel, transactionPriceLabel, columnBottomLineView].forEach {
            view.addSubview($0)
        }
        columnTopLineView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        coinNameLabel.snp.makeConstraints {
            $0.top.equalTo(columnTopLineView.snp.bottom).offset(5 * ScreenFigure.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.bottom.equalTo(columnBottomLineView.snp.bottom).offset(-5 * ScreenFigure.VRatioValue)
        }
        currentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(coinNameLabel)
            $0.right.equalTo(percentOfPreviousDayLabel.snp.left).offset(-19 * ScreenFigure.HRatioValue)
        }
        percentOfPreviousDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(coinNameLabel)
            $0.right.equalTo(transactionPriceLabel.snp.left).offset(-41 * ScreenFigure.HRatioValue)
        }
        transactionPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(coinNameLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
        columnBottomLineView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        return view
    }()
    let columnTopLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let coinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "코인명"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .semibold, size: 11)
        return label
    }()
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "현재가"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .semibold, size: 11)
        return label
    }()
    let percentOfPreviousDayLabel: UILabel = {
        let label = UILabel()
        label.text = "전일대비"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .semibold, size: 11)
        return label
    }()
    let transactionPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "거래대금"
        label.textColor = .white
        label.font = PurpleCoinFont.font(type: .semibold, size: 11)
        return label
    }()
    let columnBottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    //MARK: coinTableView
    let coinTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = PurpleCoinColor.darkPointColor
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        [topView, valuationView, sortingButtonView, columnTitleView, coinTableView].forEach {
            addSubview($0)
        }
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        valuationView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        sortingButtonView.snp.makeConstraints {
            $0.top.equalTo(valuationView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        columnTitleView.snp.makeConstraints {
            $0.top.equalTo(sortingButtonView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        coinTableView.snp.makeConstraints {
            $0.top.equalTo(columnTitleView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
