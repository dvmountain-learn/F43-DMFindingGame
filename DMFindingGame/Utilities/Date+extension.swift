//
//  Date+extension.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 12/4/23.
//

import Foundation

extension Date {
    func format(format: String = "dd-MM-yyyy hh-mm-ss") -> Date {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
         let dateString = dateFormatter.string(from: self)
         if let newDate = dateFormatter.date(from: dateString) {
             return newDate
         } else {
             return self
         }
     }
}
