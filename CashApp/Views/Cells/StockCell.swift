//
//  StockCell.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/27/21.
//

import UIKit

class StockCell: UICollectionViewCell {

    // MARK: - Properties
    static let reuseID = "StockCell"
    private let stockTickerLabel = CashAppTitleLabel(textAlignment: .center, fontSize: 22)
    private let priceLabel = CashAppSecondaryTitle(textAlignment: .center, size: 18)
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    private func configure() {
        addSubview(stockTickerLabel)
        addSubview(priceLabel)
        backgroundColor = .cashGreen
        layer.cornerRadius = 15
        layer.masksToBounds = true
        let padding: CGFloat = 3
        NSLayoutConstraint.activate([
            stockTickerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stockTickerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)  ,
            stockTickerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            priceLabel.topAnchor.constraint(equalTo: stockTickerLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    func set(stock: Stock) {
        let viewModel =  StockViewModel(stock: stock)
        stockTickerLabel.text = viewModel.ticker
        priceLabel.text = "\(viewModel.currency) " + String(viewModel.price)
    }
}
