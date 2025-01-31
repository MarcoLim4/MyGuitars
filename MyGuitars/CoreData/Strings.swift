//
//  Strings.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-30.
//
//

import Foundation
import SwiftData


@Model
final class Strings {

    var brand: String?
    var comments: String?
    var date: Date?
    var gauge: String?
    var lifespan: Int16? = 0
    var myrating: Int16? = 0
    var price: Double? = 0.0
    var remembertochange: Bool?
    var instruments: Instruments?
    
    public init() {

    }
    
}
