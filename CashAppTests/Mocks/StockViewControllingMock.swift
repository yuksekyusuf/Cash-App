//
//  StockViewControllingMock.swift
//  CashAppTests
//
//  Created by Ahmet Yusuf Yuksek on 1/6/22.
//

import Foundation
import UIKit
@testable import CashApp

class StockViewControllingMock: StockViewControlling {
    var invokedUIViewControllerGetter = false
    var invokedUIViewControllerGetterCount = 0
    var stubbedUIViewController: UIViewController!
    var uiViewController: UIViewController {
        invokedUIViewControllerGetter = true
        invokedUIViewControllerGetterCount += 1
        return stubbedUIViewController
    }
    var invokedUpdateData = false
    var invokedUpdateDataCount = 0
    var invokedUpdateDataParameters: (stocks: [Stock], Void)?
    var invokedUpdateStocksParametersList = [(stocks: [Stock], Void)]()
    func updateData(on stocks: [Stock]) {
        invokedUpdateData = true
        invokedUpdateDataCount += 1
        invokedUpdateDataParameters = (stocks, ())
        invokedUpdateStocksParametersList.append((stocks, ()))
    }
    var invokedPresentAlert = false
    var invokedPresentAlertCount = 0
    var invokedPresentAlertParameters: (title: String, message: String, Void)?
    var invokedPresentAlertParametersList = [(title: String, message: String, Void)]()
    func presentAlert(title: String, message: String) {
        invokedPresentAlert = true
        invokedPresentAlertCount += 1
        invokedPresentAlertParameters = (title, message, ())
        invokedPresentAlertParametersList.append((title, message, ()))
    }
}
