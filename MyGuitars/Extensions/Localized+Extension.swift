//
//  Localized+Extension.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-03-23.
//

import Foundation


extension String {
    
    var localized: String {
        
        var result = Bundle.main.localizedString(forKey: self, value: nil, table: nil)

        if result == self {
            
//            switch BaseService.origin {
//            case .pcg:
//                result = Bundle.main.localizedString(forKey: self, value: nil, table: "Localized-PCG")
//            case .as:
//                result = Bundle.main.localizedString(forKey: self, value: nil, table: "Localized-CAS-AS")
//            case .cs:
//                result = Bundle.main.localizedString(forKey: self, value: nil, table: "Localized-CAS-CS")
//            default:
                result = self
//            }
        }
        return result
    }
    
    func localized(from table: String) -> String {

        var result = Bundle.main.localizedString(forKey: self, value: nil, table: table)

        if result == self {
            result = Bundle.main.localizedString(forKey: self, value: nil, table: table)
        }
        return result
    }
    
    
}
