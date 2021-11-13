//
//  StocksVC.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/29/21.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    let logoImageView = UIImageView()
    let welcomeButton = CashAppButton(backgroundColor: .cashGreen, title: "Get Stocks")

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cashYellow
        configureLogoImageView()
        configureButton()
    }
    // MARK: - UIConfigurations

    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "cash-app")
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    private func configureButton() {
        view.addSubview(welcomeButton)
        welcomeButton.addTarget(self, action: #selector(pushStocksVC), for: .touchUpInside)
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            welcomeButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            welcomeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            welcomeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            welcomeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    // MARK: - Selectors
    @objc func pushStocksVC() {
        let stockService = StockService()
        let interactor = StocksInteractor(stockService: stockService)
        let viewController = StocksViewController(interactor: interactor)
        interactor.viewController = viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
