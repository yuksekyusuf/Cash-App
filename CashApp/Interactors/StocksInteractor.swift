//
//  StocksInteractor.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/31/21.
//

// This is an interactor, inspired by VIPER and clean architecture. It runs the business logic for
// StocksViewController. This service receives a dependency, a service class, by leveraging
// protocol-oriented programming.
// The viewcontroller is assigned externally.
// I used this approach to make this class/interactor testable.

import UIKit

protocol StocksInteracting: AnyObject {
    func fetchStocks()
    func searchResults(with text: String?)
    func cancelButtonTapped()
    func cellTapped(on indexPath: IndexPath) -> UIViewController
    var stocks: [Stock] { get }
    var filteredStocks: [Stock] { get set }
    var isSearching: Bool { get set }
}

class StocksInteractor: StocksInteracting {
    weak var viewController: StockViewControlling?
    var isSearching: Bool = false
    var stocks = [Stock]()
    var filteredStocks = [Stock]()
    private var stockService: StockServicing
    init(stockService: StockServicing) {
        self.stockService = stockService
    }
    // MARK: UpdatesData after Search
    func searchResults(with text: String?) {
        guard let filter = text, !filter.isEmpty else { return }
        isSearching = true
        filteredStocks = self.stocks.filter { $0.ticker.lowercased().contains(filter.lowercased())}
        self.viewController?.updateData(on: filteredStocks)
    }
    // MARK: - Fetch stocks data
    func fetchStocks() {
        stockService.getStocks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let stocksData):
                self.stocks = stocksData
                self.viewController?.updateData(on: self.stocks)
                if self.stocks.isEmpty {
                    let message = "This endpoint has no data. Try another url please!"
                    self.viewController?.presentAlert(title: "No Value", message: message)
                }
            case .failure(let error):
                self.viewController?.presentAlert(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    // MARK: - Handles when cancel button is tapped in the search bar
    func cancelButtonTapped() {
        isSearching = false
        self.viewController?.updateData(on: stocks)
    }
    // MARK: - Handles when a cell is tapped
    func cellTapped(on indexPath: IndexPath) -> UIViewController {
        let activeArray = isSearching ? filteredStocks : stocks
        let stock = activeArray[indexPath.row]
        let viewControllerSingleStock = SingleStockViewController(stock: stock)
        return viewControllerSingleStock
    }
}
