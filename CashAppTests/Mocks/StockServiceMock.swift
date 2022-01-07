//
//  StockServiceMock.swift
//  CashAppTests
//
//  Created by Ahmet Yusuf Yuksek on 1/6/22.
//

import Foundation
@testable import CashApp

class StockServiceMock {
    var invokedGetStocks = false
    var invokedGetStocksCount = 0
    var stubbedGetPortfolioCompletionHandlerResult: (Result<[Stock], CashAppErrors>, Void)?
    func getStocks(completionHandler: @escaping (Result<[Stock], CashAppErrors>) -> Void) {
        invokedGetStocks = true
        invokedGetStocksCount += 1
        if let result = stubbedGetPortfolioCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
