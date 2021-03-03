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


extension Double {
    
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func stringValue() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        let sumFormatted =  formatter.string(from: NSNumber(value: self)) ?? "$0"

        return sumFormatted
        
    }
}
