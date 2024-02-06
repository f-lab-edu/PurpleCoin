//
//  OrderBookTableViewCell.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/07.
//

import UIKit

final class OrderBookTableViewCell: UITableViewCell {
    
    private enum Font {
        static let defaultFont = PurpleCoinFont.font(type: .regular, size: 14)
        static let smallFont = PurpleCoinFont.font(type: .regular, size: 12)
    }
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.defaultFont
        label.text = "325"
        label.textColor = .red
        return label
    }()
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = Font.smallFont
        label.text = "0.33%"
        label.textColor = .red
        return label
    }()
    let middleLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = Font.defaultFont
        label.textColor = .white
        label.text = "0.33"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = PurpleCoinColor.darkPointColor
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Layout
extension OrderBookTableViewCell {
    func setLayout() {
        [priceLabel, percentageLabel, middleLineView, barView, amountLabel].forEach {
            contentView.addSubview($0)
        }
        priceLabel.snp.makeConstraints {
            $0.right.equalTo(barView.snp.left).offset(-5)
            $0.bottom.equalTo(contentView.snp.centerY).offset(-2)
        }
        percentageLabel.snp.makeConstraints {
            $0.right.equalTo(priceLabel)
            $0.top.equalTo(contentView.snp.centerY).offset(2)
        }
        middleLineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(1)
        }
        barView.snp.makeConstraints {
            $0.left.equalTo(middleLineView.snp.right)
            $0.height.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
        amountLabel.snp.makeConstraints {
            $0.left.equalTo(middleLineView.snp.right).offset(3)
            $0.centerY.equalToSuperview()
        }
    }
}
