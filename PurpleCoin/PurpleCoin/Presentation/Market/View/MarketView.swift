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
    
    let valuationView: UIView = {
        let view = UIView()
        return view
    }()
    
    let columnTitleView: UIView = {
        let view = UIView()
        return view
    }()
    
    let coinListView: UITableView = {
        let tableView = UITableView()
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
        [topView].forEach {
            addSubview($0)
        }
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}
