//
//  StocksServiceTest.swift
//  CashAppTests
//
//  Created by Ahmet Yusuf Yuksek on 1/21/22.
//

import Foundation
import XCTest
@testable import CashApp

class StocksServiceTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    func test_getStocks_whenSucces() {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            fatalError("Fixture not found")
        }
        let service = StockService()
        var resultStocks: [Stock] = []
        var resultError: Error?
        service.getStocks { result in
            switch result {
            case .success(let stocks):
                resultStocks = stocks
            case .failure(let error):
                resultError
            }
        }
        XCTAssertNil(resultError)
//        XCTAssertEqual(resultStocks.count, 1)
    }
    private func readFixture(fileName: String) -> Data {
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            fatalError("Fixture not found")
        }
        
        guard let string = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Can't read file")
        }
        guard let data = string.data(using: .utf8) else {
            fatalError("Can't convert to data")
        }
        return data
    }
}
