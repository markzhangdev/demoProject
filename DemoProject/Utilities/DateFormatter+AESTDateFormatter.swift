//
//  DateFormatter+AESTDateFormatter.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public extension DateFormatter {
    /// Creates a convient date formatter instance with gregorian calendar
    static var AESTDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        formatter.locale = Locale(identifier: "en_AU")
        formatter.timeZone = TimeZone(identifier: "Australia/Brisbane") ?? TimeZone(secondsFromGMT: 60 * 60 * 10)!
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
}
