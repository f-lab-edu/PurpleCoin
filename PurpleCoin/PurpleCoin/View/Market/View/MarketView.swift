//
//  MarketView.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class MarketView: UIView {
    
    private enum Font {
        static let valuationLabelFont = PurpleCoinFont.font(type: .medium, size: 12)
        static let sortingButtonFont = PurpleCoinFont.font(type: .semibold, size: 13)
        static let cloumnTitleLabelFont = PurpleCoinFont.font(type: .semibold, size: 11)
    }
    
    //MARK: topSection
    let topView = MarketTopView()
    
    //MARK: valuationSection
    lazy var valuationView = MarketValuationView()
    
    //MARK: sortingButtonSection
    lazy var sortingButtonView = MarketSortingButtonView()
    
    //MARK: columnTitleSection
    lazy var columnTitleView = MarketColumnTitleView()
    
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
}

//MARK: Layout
extension MarketView {
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
