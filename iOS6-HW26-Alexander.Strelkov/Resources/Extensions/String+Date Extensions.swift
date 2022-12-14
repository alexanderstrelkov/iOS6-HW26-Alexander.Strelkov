//
//  Extencions.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 21.08.2022.
//

import Foundation
import UIKit

extension String {
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.date(from: self)
    }
}

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}


