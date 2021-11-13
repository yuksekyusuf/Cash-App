//
//  StockViewModel.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/29/21.
//

import UIKit

struct StockViewModel {
    private let stock: Stock
    init(stock: Stock) {
        self.stock = stock
    }
    var ticker: String {
        let ticker = matches(for: "[A-Za-z]", in: stock.ticker)
        return ticker
    }
    var currency: String {
        if stock.currency == "USD" {
            return stock.currency
        } else {
            return "USD"
        }
    }
    var timeStamp: String {
        let time = stock.currentPriceTimestamp
        return dateFormatter(for: time) ?? "N/A"
    }
    var price: String {
        if stock.currentPriceCents > 100 {
            let price = Double(stock.currentPriceCents) / 100
            return String(price)
        } else {
            return String("0.\(stock.currentPriceCents)")
        }
    }
    var quantity: String {
        if let quantity = stock.quantity {
            return String(quantity)
        } else {
            return "N/A"
        }
    }
    // MARK: - Helpers
    func matches(for regex: String, in text: String) -> String {
        var results = [String]()
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let resultss = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            results = resultss.map { String(text[Range($0.range, in: text)!]) }
            let resultsString = results.joined()
            return resultsString
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    func dateFormatter(for time: Int) -> String? {
        let date = Date(timeIntervalSince1970: Double(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
