//
//  Dste+Extension.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-03-01.
//

import SwiftUI

extension Date {
    
//    func toString(format: String = "yyyy-MM-dd") -> String {
    func toString(format: String = "MMM dd, yyyy") -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
        
    }
    
}
