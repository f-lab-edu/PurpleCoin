//
//  DetailCoinViewController.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class DetailCoinViewController: UIViewController {
    
    let detailCoinView = DetailCoinView()
    let viewModel = DetailCoinViewModel()
    var marketCode: String
    var krwName: String
    
    override func loadView() {
        super.loadView()
        view = detailCoinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMarketData(marketCode: marketCode) { [self] _ in
            detailCoinView.setAttributes(krwName: krwName, marketData: viewModel.marketData)
            viewModel.getOrderBookData(marketCode: marketCode) { [self] error in
                if let error = error {
                    switch error {
                    case .decodingError:
                        self.showAlert(message: "디코딩 에러")
                    case .orderBookFetchingError:
                        self.showAlert(message: "호가정보 패치 에러")
                    }
                } else {
                    detailCoinView.orderBookTableView.reloadData()
                }
            }
        }
        bindAction()
        setTableView()
        setInterestButton()
    }
    
    init(krwName: String, marketCode: String) {
        self.krwName = krwName
        self.marketCode = marketCode
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
        return (viewModel.orderBookData?.orderbookUnits.count ?? 0) * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderBookTableViewCell(style: OrderBookTableViewCell.CellStyle.default, reuseIdentifier: "cell")
        guard let marketData = viewModel.marketData,
              let orderBookData = viewModel.orderBookData
        else {
            return UITableViewCell()
        }
        let orderBookUnits = orderBookData.orderbookUnits
        let isAsk = checkAsk()
        var orderBookUnit: OrderBookUnit
        if checkAsk()  {
            orderBookUnit = orderBookUnits.reversed()[indexPath.row]
        } else {
            orderBookUnit = orderBookUnits[indexPath.row - orderBookUnits.count]
        }
        bindData()
        setCellAttributes()
        return cell
        
        func bindData() {
            let formattedData = formattData()
            cell.priceLabel.text = formattedData.price
            cell.amountLabel.text = formattedData.size
            cell.percentageLabel.text = formattedData.dtdPercentage
            let ratio = isAsk ? orderBookUnit.askSize/orderBookData.totalAskSize : orderBookUnit.bidSize/orderBookData.totalBidSize
            cell.barView.snp.makeConstraints {
                $0.width.equalTo(ScreenFigure.bounds.width * ratio)
            }
        }
        
        func formattData() -> (price: String, dtdPercentage: String, size: String) {
            let price = isAsk ? orderBookUnit.askPrice : orderBookUnit.bidPrice
            return (
                price: Formatter.formatNumberWithCustomRules(for: price),
                dtdPercentage: Formatter.truncateToTwoDecimals(for: (price - marketData.openingPrice)/marketData.openingPrice * 100) + "%",
                size: Formatter.formatNumberWithCustomRules(for: orderBookUnit.bidSize)
            )
        }
        
        func setCellAttributes() {
            var bgColor = UIColor.clear
            var labelColor = UIColor.clear
            var barColor = UIColor.clear
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
            } else if marketData.openingPrice > price {
                labelColor = PurpleCoinColor.blue
            }
            cell.backgroundColor = bgColor
            cell.priceLabel.textColor = labelColor
            cell.percentageLabel.textColor = labelColor
            cell.barView.backgroundColor = barColor
        }
        
        func checkAsk() -> Bool{
            return indexPath.row < orderBookUnits.count
        }
    }
    
}
