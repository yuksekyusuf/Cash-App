//
//  SingleStockVC.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/29/21.
//

import UIKit

class SingleStockViewController: UIViewController {
    // MARK: - Properties
    var stock: Stock
    init(stock: Stock) {
        self.stock = stock
        super.init(nibName: nil, bundle: nil)
    }
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    private lazy var stockTitle: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    private lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.textColor = .cashGreen
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private lazy var quantTitle: UILabel = {
        let label = UILabel()
        label.textColor = .systemIndigo
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    private lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.textColor = .systemTeal
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    private lazy var nameTitle = CashAppSecondaryTitle(textAlignment: .center, size: 15)
    let dismissButton = CashAppButton(backgroundColor: .systemRed, title: "Dismiss")
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureStacks()
        configureButtons()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI Configurations
    private func configureContainerView() {
        view.addSubview(containerView)

        containerView.backgroundColor = .cashYellow
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.cashGreen.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    private func configureStacks() {
        let viewModel = StockViewModel(stock: stock)
        let buttonStack = UIStackView(arrangedSubviews: [dismissButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        buttonStack.distribution = .equalSpacing
        let stack = UIStackView(arrangedSubviews:
                                    [stockTitle, nameTitle, priceTitle,
                                     quantTitle, buttonStack, dateTitle]
        )
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        stockTitle.text = viewModel.ticker
        priceTitle.text = "Price: \(viewModel.currency) \(viewModel.price)"
        nameTitle.text = "\(stock.name)"
        nameTitle.textColor = .systemRed
        quantTitle.text = "Stock Quantity: \(viewModel.quantity)"
        dateTitle.text = "Last updated in \(viewModel.timeStamp)"
        dateTitle.textAlignment = .center
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func configureButtons() {
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    // MARK: - Selectors
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
}
