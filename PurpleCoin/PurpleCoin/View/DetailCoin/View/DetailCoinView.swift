//
//  DetailCoinView.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

final class DetailCoinView: UIView {
    
    private enum Font {
        static let topTitleLabelFont = PurpleCoinFont.font(type: .bold, size: 20)
        static let priceLabelFont = PurpleCoinFont.font(type: .regular, size: 16)
        static let defaultFont = PurpleCoinFont.font(type: .regular, size: 12)
    }
    
    private enum Metric {
        static let backButtonSize = CGSize(width: 30 * ScreenFigure.Ratio.VRatioValue, height: 30 * ScreenFigure.Ratio.VRatioValue)
        static let intrestButtonSize = CGSize(width: 20 * ScreenFigure.Ratio.VRatioValue, height: 20 * ScreenFigure.Ratio.VRatioValue)
    }
    
    //MARK: topSection
    let topView = DetailCoinTopView()
    
    //MARK: coinInformationSection
    let coinInformationView = CoinInformationView()
    
    //MARK: chartSection
    let chartView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: orderBookSection
    let orderBookTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = PurpleCoinColor.darkPointColor
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.bounces = false
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
extension DetailCoinView {
    func setLayout() {
        [topView, coinInformationView, chartView, orderBookTableView].forEach {
            addSubview($0)
        }
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(ScreenFigure.topViewHeight())
        }
        coinInformationView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        chartView.snp.makeConstraints {
            $0.top.equalTo(coinInformationView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        orderBookTableView.snp.makeConstraints {
            $0.height.equalTo(300 * ScreenFigure.Ratio.VRatioValue)
            $0.bottom.left.right.equalToSuperview()
        }
    }
}

//MARK: SetAttributes
extension DetailCoinView {
    func setAttributes(krwName: String, marketData: MarketData?) {
        guard let marketData = marketData else {
            return
        }
        let formattedData = formattData()
        topView.topTitleLabel.text = krwName
        coinInformationView.coinPriceLabel.text = formattedData.currentPrice
        var arrow = ""
        var color = UIColor.white
        switch marketData.change {
        case "EVEN":
            break
        case "RISE":
            arrow = "▲"
            color = PurpleCoinColor.red
        case "FALL":
            arrow = "▼"
            
            color = PurpleCoinColor.blue
        default:
            break
        }
        coinInformationView.coinDTDLabel.text = "\(formattedData.dtdPercent) \(arrow)\(formattedData.dtdPrice)"
        coinInformationView.coinPriceLabel.textColor = color
        coinInformationView.coinDTDLabel.textColor = color
        
        func formattData() -> (currentPrice: String, dtdPercent: String, dtdPrice: String) {
            return (
                currentPrice: Formatter.formatNumberWithCustomRules(for: marketData.tradePrice),
                dtdPercent: Formatter.truncateToTwoDecimals(for: marketData.signedChangeRate * 100) + "%",
                dtdPrice: Formatter.formatNumberWithCustomRules(for: marketData.signedChangePrice)
            )
        }
    }
}
