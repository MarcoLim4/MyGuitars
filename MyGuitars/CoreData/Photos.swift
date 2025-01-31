//
//  Photos.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-30.
//
//

import Foundation
import SwiftData


@Model
final class Photos {
    var comments: String?
    var photo: Data?
    var instruments: Instruments?
    public init() {

    }
    
}
