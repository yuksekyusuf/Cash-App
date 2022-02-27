//
//  CashAppTests.swift
//  CashAppTests
//
//  Created by Ahmet Yusuf Yuksek on 12/22/21.
//

import XCTest
@testable import CashApp

class StocksInteractorTests: XCTestCase {
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
        interactor.fetchStocks()
        XCTAssertEqual(serviceMock.invokedGetStocksCount, 1)
        XCTAssertEqual(viewControllerMock.invokedUpdateDataCount, 1)
        XCTAssertEqual(viewControllerMock.invokedPresentAlertCount, 0)
    }
    
    func test_getStocks_failure() {
        serviceMock.stubbedGetStocksComplitionResult = (.failure(CashAppErrors.unableToComplete), ())
        XCTAssertEqual(serviceMock.invokedGetStocksCount, 0)
        XCTAssertEqual(viewControllerMock.invokedUpdateDataCount, 0)
        interactor.fetchStocks()
        XCTAssertEqual(viewControllerMock.invokedPresentAlertCount, 1)
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
