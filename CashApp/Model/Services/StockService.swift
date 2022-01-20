//
//  NetworkManager.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/27/21.
//

import UIKit

protocol StockServicing {
    func getStocks(complition: @escaping (Result<[Stock], CashAppErrors>) -> Void)
}
class StockService: StockServicing {
    private let baseURL = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    func getStocks(complition: @escaping (Result<[Stock], CashAppErrors>) -> Void) {
        let endpoint = baseURL
        guard let url = URL(string: endpoint) else { return }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    DispatchQueue.main.async {
                        complition(.failure(.unableToComplete))
                    }
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    DispatchQueue.main.async {
                        complition(.failure(.invalidResponse))
                    }
                    return
                }
                guard let data = data else {
                    DispatchQueue.main.async {
                        complition(.failure(.invalidData))
                    }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let stocks = try decoder.decode(Stocks.self, from: data)
                    DispatchQueue.main.async {
                        complition(.success(stocks.stocks))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure(.invalidData))
                    }
                }
            }
            task.resume()
    }
}
