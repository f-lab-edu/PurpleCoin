//
//  MainViewController.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class MainViewController: UIViewController {

    enum BottomMenu: Int {
        case market
        case asset
    }
    var displayMenu: BottomMenu = .market
    let childVCFrame = CGRect(x: 0,
                              y: 0,
                              width: ScreenFigure.bounds.width,
                              height: ScreenFigure.bounds.height
    )

    let mainView = MainView()
    let apiService: APIService

    lazy var marketViewController: MarketViewController = {
        let marketVC = MarketViewController(apiService: apiService)
        marketVC.additionalSafeAreaInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: ScreenFigure.bottomNavigationViewHeight(),
            right: 0
        )
        marketVC.view.frame = childVCFrame
        return marketVC
    }()
    lazy var assetViewController: AssetViewController = {
        let assetVC = AssetViewController()
        assetVC.additionalSafeAreaInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: ScreenFigure.bottomNavigationViewHeight(),
            right: 0
        )
        assetVC.view.frame = childVCFrame
        return assetVC
    }()

    init(apiService: APIService) {
        self.apiService = apiService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        changeDisplayingVC()
    }

    func configureView() {
        view = mainView
    }

    func changeDisplayingVC() {
        [marketViewController, assetViewController].forEach {
            $0.removeFromParent()
            $0.view.removeFromSuperview()
        }
        switch displayMenu {
        case .market:
            addChild(marketViewController)
            view.addSubview(marketViewController.view)
        case .asset:
            addChild(assetViewController)
            view.addSubview(assetViewController.view)
        }
        view.bringSubviewToFront(mainView.bottomNavigationView)
    }
}

// MARK: BindActon
extension MainViewController {
    func bindAction() {
        mainView.bottomNavigationView.navigationControls.forEach {
            $0.addTarget(self, action: #selector(bottomNavigationControlTapped(_ :)), for: .touchUpInside)
        }
    }

    @objc func bottomNavigationControlTapped(_ sender: UIControl) {
        let tag = sender.tag
        displayMenu = BottomMenu(rawValue: tag) ?? .market
        changeDisplayingVC()
    }
}
