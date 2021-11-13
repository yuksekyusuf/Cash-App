//
//  Stock.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/27/21.
//

import Foundation

struct Stocks: Codable, Hashable {
    let stocks: [Stock]
}
struct Stock: Codable, Hashable {
    let ticker: String
    let name: String
    let currency: String
    let currentPriceCents: Int
    var quantity: Int?
    let currentPriceTimestamp: Int
}
