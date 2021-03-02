//
//  Number+Extension.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-03-01.
//

import SwiftUI

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
}
