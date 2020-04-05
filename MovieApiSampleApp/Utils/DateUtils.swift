//
//  DateUtils.swift
//  tableView
//
//  Created by David Marjanović on 02/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

class DateUtils{
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    static func getYearFromDate(stringDate: String) -> String{
        guard let safeDate = dateFormatter.date(from: stringDate) else {return "0000"}
        let calendar = Calendar.current
        return String(calendar.component(.year, from: safeDate))
    }
    
}
