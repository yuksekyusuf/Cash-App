//
//  MockViewControlling.swift
//  CashAppTests
//
//  Created by Ahmet Yusuf Yuksek on 1/19/22.
//

import Foundation
import UIKit
@testable import CashApp

class MockViewControlling: StockViewControlling {
    var invokedUpdateData = false
    var invokedUpdateDataCount = 0
    var invokedUpdateDataParameters: (stocks: [Stock], Void)?
    var invokedUpdateDataParametersList = [(stocks: [Stock], Void)]()

    func updateData(on stocks: [Stock]) {
        invokedUpdateData = true
        invokedUpdateDataCount += 1
        invokedUpdateDataParameters = (stocks, ())
        invokedUpdateDataParametersList.append((stocks, ()))
    }
    var invokedPresentAlert = false
    var invokedPresentAlertCount = 0
    var invokedPresentAlertParameters: (title: String, message: String)?
    var invokedPresentAlertParametersList = [(title: String, message: String)]()

    func presentAlert(title: String, message: String) {
        invokedPresentAlert = true
        invokedPresentAlertCount += 1
        invokedPresentAlertParameters = (title, message)
        invokedPresentAlertParametersList.append((title, message))
    }
}
