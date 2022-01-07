//
//  CashAppTests.swift
//  CashAppTests
//
//  Created by Ahmet Yusuf Yuksek on 12/22/21.
//

import XCTest
@testable import CashApp

class StocksInteractorTests: XCTestCase {
    enum TestError: Error {
        case mock
    }
    let viewControllerMock = StockViewControllingMock()
    var service = StockServiceMock()
    var interactor: StocksInteractor!
    override func setUp() {
        super.setUp()
    }
    
    
    
    
    private func createExampleStock() -> Stock {
        return Stock(ticker: "SQ",
                     name: "Square INC",
                     currency: "USD",
                     currentPriceCents: 44,
                     quantity: 0,
                     currentPriceTimestamp: 11)
    }
}
