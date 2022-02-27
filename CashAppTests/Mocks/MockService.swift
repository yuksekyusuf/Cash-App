//
//  MockInteractor.swift
//  CashAppTests
//
//  Created by Ahmet Yusuf Yuksek on 1/19/22.
//

import Foundation
import UIKit
@testable import CashApp

class MockService: StockServicing {
    var invokedGetStocks = false
    var invokedGetStocksCount = 0
    var stubbedGetStocksComplitionResult: (Result<[Stock], CashAppErrors>, Void)?

    func getStocks(complition: @escaping (Result<[Stock], CashAppErrors>) -> Void) {
        invokedGetStocks = true
        invokedGetStocksCount += 1
        if let result = stubbedGetStocksComplitionResult {
            complition(result.0)
        }
    }
}
