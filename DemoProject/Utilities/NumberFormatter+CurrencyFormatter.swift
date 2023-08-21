//
//  NumberFormatter+CurrencyFormatter.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public extension NumberFormatter {
    /// Get aud currency number formatter.
    /// - Returns: The number formatter with aud as currency
    static func currencyFormatterAUD() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_AU")
        formatter.numberStyle = .currency
        return formatter
    }

    static func plainNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_AU")
        formatter.numberStyle = .none
        formatter.groupingSeparator = ""
        return formatter
    }
}
