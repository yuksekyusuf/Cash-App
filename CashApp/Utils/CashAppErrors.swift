//
//  CAErrors.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/27/21.
//

import Foundation

enum CashAppErrors: String, Error {
    case unableToComplete = "Unable complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
}
