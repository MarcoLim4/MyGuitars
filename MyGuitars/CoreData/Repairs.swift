//
//  Repairs.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-30.
//
//

import Foundation
import SwiftData


@Model
final class Repairs {
    var comments: String?
    var cost: Double? = 0.0
    var dateperformed: Date?
    var repairedby: String?
    var repairrate: Int16? = 0
    var repairtype: String?
    var instruments: Instruments?
    public init() {

    }
    
}
