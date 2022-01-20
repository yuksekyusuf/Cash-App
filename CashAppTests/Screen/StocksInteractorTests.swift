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
    let viewControllerMock = MockViewControlling()
    var serviceMock = MockService()
    var interactor: StocksInteractor!
    override func setUp() {
        super.setUp()
        interactor = StocksInteractor(stockService: serviceMock)
        interactor.viewController = viewControllerMock
    }
    
    func test_getStocks_success() {
        // assert
        serviceMock.stubbedGetStocksComplitionResult = (.success([createExampleStock()]), ())
        XCTAssertEqual(serviceMock.invokedGetStocksCount, 0)
        XCTAssertEqual(viewControllerMock.invokedUpdateDataCount, 0)
        XCTAssertEqual(viewControllerMock.invokedPresentAlertCount, 0)
        interactor.getStocks()
        XCTAssertEqual(serviceMock.invokedGetStocksCount, 1)
        XCTAssertEqual(viewControllerMock.invokedUpdateDataCount, 1)
        XCTAssertEqual(viewControllerMock.invokedPresentAlertCount, 0)
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
