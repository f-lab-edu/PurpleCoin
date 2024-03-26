//
//  MarketViewController.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

final class MarketViewController: UIViewController {

    let apiService: APIService

    let marketView = MarketView()
    let viewModel: MarketViewModel

    var sortingType: MarketCoinType
    var marketDatas: [MarketData]?
    var allMarketCodes: [MarketCode]?

    init(apiService: APIService) {
        self.apiService = apiService
        self.viewModel = MarketViewModel(apiService: apiService)
        self.sortingType = .krw
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        congifureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMarketData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        setSortingType(type: .krw)
        setTableView()
    }

    func congifureView() {
        view = marketView
    }

    func fetchMarketData() {
        Task {
            do {
                self.marketDatas = try await viewModel.fetchMarketData()
                self.marketView.coinTableView.reloadData()
            } catch {
                handleError(error: error)
            }
        }
    }
    
    func handleError(error: Error) {
        if let marketError = error as? MarketError {
            marketError.getErrorWarning()
        } else {
            showToast(message: "알 수 없는 에러")
        }
    }

    func setTableView() {
        marketView.coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "cell")
        marketView.coinTableView.delegate = self
        marketView.coinTableView.dataSource = self
    }
    
    func setSortingType(type: MarketCoinType) {
        self.sortingType = type
        viewModel.setCoinType(marketCoinType: type)
    }
}

// MARK: BindAction
extension MarketViewController {
    func bindAction() {
        [
            marketView.sortingButtonView.sortingOfKRWButton,
            marketView.sortingButtonView.sortingOfBTCButton,
            marketView.sortingButtonView.sortingOfIntrestButton
        ].forEach {
            $0.addTarget(
                self,
                action: #selector(sortingButtonTapped(_ :)),
                for: .touchUpInside
            )
        }
    }

    @objc func sortingButtonTapped(_ sender: UIButton) {
        guard marketDatas != nil else {
            return
        }
        [
            marketView.sortingButtonView.sortingOfKRWButton,
            marketView.sortingButtonView.sortingOfBTCButton,
            marketView.sortingButtonView.sortingOfIntrestButton
        ].forEach {
            $0.layer.borderColor = UIColor.white.cgColor
            $0.setTitleColor(.white, for: .normal)
        }
        sender.layer.borderColor = PurpleCoinColor.selectColor.cgColor
        sender.setTitleColor(PurpleCoinColor.selectColor, for: .normal)
        if sender == marketView.sortingButtonView.sortingOfKRWButton {
            setSortingType(type: .krw)
            fetchMarketData()
        } else if sender == marketView.sortingButtonView.sortingOfBTCButton {
            setSortingType(type: .btc)
            fetchMarketData()
        } else if sender == marketView.sortingButtonView.sortingOfIntrestButton {
            setSortingType(type: .intrested)
            fetchMarketData()
        }
    }
}

// MARK: TableView
extension MarketViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * ScreenFigure.Ratio.VRatioValue
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketDatas?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoinTableViewCell(style: CoinTableViewCell.CellStyle.default, reuseIdentifier: "cell")
        guard let marketDatas = marketDatas,
              let marketCodes = NetworkConfig.shared.allMarketCodes
        else {
            return UITableViewCell()
        }
        let marketData = marketDatas[indexPath.row]
        let formattedData = formattData(marketCodes: marketCodes, marketData: marketData)
        setCellAttributes(formattedData: formattedData, cell: cell)
        setColorForPriceLabels(with: marketData.change, in: cell)
        cell.cellTapAction = {
            self.bindCellTapAction(formattedData: formattedData, marketData: marketData)
        }
        return cell
    }

    // 데이터 포멧
    func formattData(marketCodes: [MarketCode], marketData: MarketData) -> FormattedMarketData {
        return FormattedMarketData(
            krwCoinName: marketCodes.first {$0.market == marketData.market}?.koreanName ?? "??",
            englishCoinName: Formatter.convertEngCoinName(marketData.market),
            currentPrice: Formatter.formatNumberWithCustomRules(for: marketData.tradePrice),
            dtdPercentage: Formatter.truncateToTwoDecimals(for: marketData.signedChangeRate * 100) + "%",
            dtdPrice: Formatter.formatNumberWithCustomRules(for: marketData.signedChangePrice),
            transactionPrice: Formatter.formatToMillionUnit(for: marketData.accTradePrice24h)
        )
    }

    func setCellAttributes(formattedData: FormattedMarketData, cell: CoinTableViewCell) {
        cell.krwCoinNameLabel.text = formattedData.krwCoinName
        cell.englishCoinNameLabel.text = formattedData.englishCoinName
        cell.currentPriceLabel.text = formattedData.currentPrice
        cell.dtdPercentageLabel.text = formattedData.dtdPercentage
        cell.dtdPriceLabel.text = formattedData.dtdPrice
        cell.transactionPriceLabel.text = formattedData.transactionPrice
    }

    func bindCellTapAction(formattedData: FormattedMarketData, marketData: MarketData) {
        let detailCoinViewController = DetailCoinViewController(
            krwName: formattedData.krwCoinName,
            marketCode: marketData.market,
            apiService: apiService
        )
        navigationController?.pushViewController(detailCoinViewController, animated: true)
    }

    // 전일대비 색상 변경
    func setColorForPriceLabels(with state: String, in cell: CoinTableViewCell) {
        var color = UIColor()
        switch state {
        case "EVEN":
            color = .white
        case "RISE":
            color = PurpleCoinColor.red
        case "FALL":
            color = PurpleCoinColor.blue
        default:
            break
        }
        [cell.currentPriceLabel, cell.dtdPriceLabel, cell.dtdPercentageLabel].forEach {
            $0.textColor = color
        }
    }
}
