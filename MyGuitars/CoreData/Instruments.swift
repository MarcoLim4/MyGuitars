//
//  Instruments.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-30.
//
//

import Foundation
import SwiftData
import UIKit

@Model
final class Instruments {

    var backmaterial: String? = ""
    var bodyshape: String? = ""
    var brand: String? = ""
    var category: String? = ""
    var comments: String? = ""
    var datemanufactured: Date? = Date()
    var electronics: String? = ""
    var finishstyle: String? = ""
    var fretboardmaterial: String? = ""
    var madein: String? = ""
    var model: String? = ""
    var neckmaterial: String? = ""
    var neckshape: String? = ""
    var numberoffrets: Int16? = 0
    var numberofstrings: Int16? = 6
    var purchasedate: Date? = Date()
    var purchasedfrom: String? = ""
    var purchasevalue: Double? = 0.0
    var rightleft: Int16? = 0
    var saledate: Date? = Date()
    var salereason: String? = ""
    var salevalue: Double? = 0.0
    var serialnumber: String? = ""
    var sidesmaterial: String? = ""
    var sold: Bool? = false
    var soldto: String? = ""
    var topmaterial: String? = ""
    var type: String? = ""

    @Relationship(deleteRule: .cascade, inverse: \Photos.instruments) var photos: [Photos]?
    @Relationship(deleteRule: .cascade, inverse: \Repairs.instruments) var repairs: [Repairs]?
    @Relationship(deleteRule: .cascade, inverse: \Strings.instruments) var strings: [Strings]?

    init(backmaterial: String? = nil, bodyshape: String? = nil, brand: String? = nil, category: String? = nil, comments: String? = nil, datemanufactured: Date? = nil, electronics: String? = nil, finishstyle: String? = nil, fretboardmaterial: String? = nil, madein: String? = nil, model: String? = nil, neckmaterial: String? = nil, neckshape: String? = nil, numberoffrets: Int16? = nil, numberofstrings: Int16? = nil, purchasedate: Date? = nil, purchasedfrom: String? = nil, purchasevalue: Double? = nil, rightleft: Int16? = nil, saledate: Date? = nil, salereason: String? = nil, salevalue: Double? = nil, serialnumber: String? = nil, sidesmaterial: String? = nil, sold: Bool? = nil, soldto: String? = nil, topmaterial: String? = nil, type: String? = nil, photos: [Photos]? = nil, repairs: [Repairs]? = nil, strings: [Strings]? = nil) {
        self.backmaterial = backmaterial
        self.bodyshape = bodyshape
        self.brand = brand
        self.category = category
        self.comments = comments
        self.datemanufactured = datemanufactured
        self.electronics = electronics
        self.finishstyle = finishstyle
        self.fretboardmaterial = fretboardmaterial
        self.madein = madein
        self.model = model
        self.neckmaterial = neckmaterial
        self.neckshape = neckshape
        self.numberoffrets = numberoffrets
        self.numberofstrings = numberofstrings
        self.purchasedate = purchasedate
        self.purchasedfrom = purchasedfrom
        self.purchasevalue = purchasevalue
        self.rightleft = rightleft
        self.saledate = saledate
        self.salereason = salereason
        self.salevalue = salevalue
        self.serialnumber = serialnumber
        self.sidesmaterial = sidesmaterial
        self.sold = sold
        self.soldto = soldto
        self.topmaterial = topmaterial
        self.type = type
        self.photos = photos
        self.repairs = repairs
        self.strings = strings
    }

    var allStrings: [Strings] {
        let stringsArray = strings ?? []
        return stringsArray.sorted(by: { $0.date ?? Date() > $1.date ?? Date() })
    }

    var instrumentTypes: [String] {
        let types = ["Acoustic".localized, "Electric".localized, "Bass".localized, "Ukelele".localized, "Dulcimer".localized]
        return types.sorted()
    }

    var acosuticBodyTypes: [String] {
        let types = ["Dreadnought".localized, "Parlour".localized, "Jumbo".localized,
                     "Auditorium".localized, "Grand Auditorium".localized, "Classical".localized,
                     "Traveler".localized, "Mini".localized, "Tenor".localized, "Orchestra Model".localized]
        return types.sorted()
    }

    var ukeleleTypes: [String] {
        let types = ["Soprano".localized, "Concert".localized, "Tenor".localized, "Baritone".localized]
        return types.sorted()
    }

    var bassBodyTypes: [String] {
        let types = ["P-Bass".localized, "J-Bass".localized, "Modern".localized]
        return types.sorted()
    }

    var dulcimerBodyTypes: [String] {
        let types = ["Merlin M4".localized, "Tear Drop".localized, "Vintage".localized,
                     "Appalachian".localized, "Stick Dulcimer".localized,
                     "Hammered Dulcimer".localized, "Dutchland".localized]
        return types.sorted()
    }

    var electricBodyTypes: [String] {

        let types = ["Les Paul".localized, "Telecaster".localized, "Stratocaster".localized, "RG".localized, "SG".localized, "ES-45".localized]
        return types.sorted()

    }

    var otherBodyTypes: [String] {
        let types = ["Other body type".localized]
        return types.sorted()
    }

    var singlePhotoSample: Photos {
        let newImage = Photos()
        newImage.photo    = UIImage(named: "image05.png")?.pngData()
        newImage.comments = "Comments about image 05."

        return newImage
    }

    var photosSample: [Photos] {

        var someItems = [Photos]()
        for index in 1...7 {
            let newImage = Photos()
            newImage.photo    = UIImage(named: "image0\(index).png")?.pngData()
            newImage.comments = "image \(index)"
            someItems.append(newImage)
        }
        return someItems as [Photos]
    }

    var stringSample: Strings {
        let newString = Strings()
        newString.brand    = "Elixir"
        newString.gauge    = "Custom Light 10-47"
        newString.date     = Date()
        newString.comments = "Brand new set of strings"
        newString.lifespan = 2
        newString.myrating = 3
        newString.price    = 12.95
        return newString
    }

}
