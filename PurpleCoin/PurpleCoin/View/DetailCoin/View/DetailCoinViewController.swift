//
//  DetailCoinViewController.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class DetailCoinViewController: UIViewController {
    
    let apiService: APIService
    var marketCode: String
    var krwName: String
    
    let detailCoinView = DetailCoinView()
    lazy var viewModel = DetailCoinViewModel(apiService: apiService)
    
    var marketData: MarketData?
    var orderBookData: OrderBook?
    
    override func loadView() {
        super.loadView()
        view = detailCoinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        setTableView()
        setInterestButton()
        Task {
            do {
                self.marketData = try await viewModel.getMarketData(marketCode: marketCode)
                detailCoinView.setAttributes(krwName: krwName, marketData: marketData)
                self.orderBookData = try await viewModel.getOrderBookData(marketCode: marketCode)
                detailCoinView.orderBookTableView.reloadData()
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    init(krwName: String, marketCode: String, apiService: APIService) {
        self.krwName = krwName
        self.marketCode = marketCode
        self.apiService = apiService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableView() {
        detailCoinView.orderBookTableView.register(OrderBookTableViewCell.self, forCellReuseIdentifier: "cell")
        detailCoinView.orderBookTableView.delegate = self
        detailCoinView.orderBookTableView.dataSource = self
    }
    
    func setInterestButton() {
        detailCoinView.topView.interestButton.isSelected = UserConfig.shared.intrestedCoins.contains(marketCode)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: BindAciton
extension DetailCoinViewController {
    func bindAction() {
        detailCoinView.topView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        detailCoinView.topView.interestButton.addTarget(self, action: #selector(interestButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func interestButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        switch sender.isSelected {
        case true:
            UserConfig.shared.intrestedCoins.append(marketCode)
        case false:
            if let indexToRemove = UserConfig.shared.intrestedCoins.firstIndex(of: marketCode) {
                UserConfig.shared.intrestedCoins.remove(at: indexToRemove)
            }
        }
    }
}

//MARK: Tableview
extension DetailCoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * ScreenFigure.Ratio.VRatioValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (orderBookData?.orderbookUnits.count ?? 0) * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderBookTableViewCell(style: .default, reuseIdentifier: "cell")
        
        guard let marketData = marketData, let orderBookData = orderBookData else {
            return UITableViewCell()
        }
        
        let orderBookUnits = orderBookData.orderbookUnits
        let isAsk = checkAsk(indexPath: indexPath, orderBookUnitsCount: orderBookUnits.count)
        let orderBookUnit = getOrderBookUnit(indexPath: indexPath, orderBookUnits: orderBookUnits, isAsk: isAsk)
        
        bindData(cell: cell, orderBookUnit: orderBookUnit, isAsk: isAsk, marketData: marketData, orderBookData: orderBookData)
        setCellAttributes(cell: cell, orderBookUnit: orderBookUnit, isAsk: isAsk, marketData: marketData)
        
        return cell
    }

    private func bindData(cell: OrderBookTableViewCell, orderBookUnit: OrderBookUnit, isAsk: Bool, marketData: MarketData, orderBookData: OrderBook) {
        let formattedData = formatData(orderBookUnit: orderBookUnit, isAsk: isAsk, marketData: marketData)
        cell.priceLabel.text = formattedData.price
        cell.amountLabel.text = formattedData.size
        cell.percentageLabel.text = formattedData.dtdPercentage
        
        let ratio = isAsk ? orderBookUnit.askSize / orderBookData.totalAskSize : orderBookUnit.bidSize / orderBookData.totalBidSize
        cell.barView.snp.makeConstraints {
            $0.width.equalTo(ScreenFigure.bounds.width * ratio)
        }
    }

    private func formatData(orderBookUnit: OrderBookUnit, isAsk: Bool, marketData: MarketData) -> (price: String, dtdPercentage: String, size: String) {
        let price = isAsk ? orderBookUnit.askPrice : orderBookUnit.bidPrice
        return (
            price: Formatter.formatNumberWithCustomRules(for: price),
            dtdPercentage: Formatter.truncateToTwoDecimals(for: (price - marketData.openingPrice) / marketData.openingPrice * 100) + "%",
            size: Formatter.formatNumberWithCustomRules(for: isAsk ? orderBookUnit.askSize : orderBookUnit.bidSize)
        )
    }

    private func setCellAttributes(cell: OrderBookTableViewCell, orderBookUnit: OrderBookUnit, isAsk: Bool, marketData: MarketData) {
        var bgColor: UIColor
        var labelColor: UIColor
        var barColor: UIColor
        
        let price = isAsk ? orderBookUnit.askPrice : orderBookUnit.bidPrice
        
        if isAsk {
            bgColor = UIColor(red: 0.145, green: 0.067, blue: 0.227, alpha: 1)
            barColor = .blue
        } else {
            bgColor = UIColor(red: 0.369, green: 0.043, blue: 0.02, alpha: 1)
            barColor = .red
        }
        
        if marketData.openingPrice < price {
            labelColor = PurpleCoinColor.red
        } else if marketData.openingPrice == price {
            labelColor = .white
        } else {
            labelColor = PurpleCoinColor.blue
        }
        
        cell.backgroundColor = bgColor
        cell.priceLabel.textColor = labelColor
        cell.percentageLabel.textColor = labelColor
        cell.barView.backgroundColor = barColor
    }

    private func checkAsk(indexPath: IndexPath, orderBookUnitsCount: Int) -> Bool {
        return indexPath.row < orderBookUnitsCount
    }

    private func getOrderBookUnit(indexPath: IndexPath, orderBookUnits: [OrderBookUnit], isAsk: Bool) -> OrderBookUnit {
        return isAsk ? orderBookUnits.reversed()[indexPath.row] : orderBookUnits[indexPath.row - orderBookUnits.count]
    }

}
