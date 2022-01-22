//
//  NetworkManager.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/27/21.
//

import UIKit

protocol StockServicing {
    func getStocks(url: String, complition: @escaping (Result<[Stock], CashAppErrors>) -> Void)
}
class StockService: StockServicing {
    
    func getStocks(url: String, complition: @escaping (Result<[Stock], CashAppErrors>) -> Void) {

        guard let url = URL(string: url) else { return }

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
