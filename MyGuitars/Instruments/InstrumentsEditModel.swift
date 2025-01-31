//
//  InstrumentsEditModel.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-31.
//

import Foundation

class InstrumentsEditModel: ObservableObject {

    var instrument: Instruments

    @Published var type: String
    @Published var brand: String
    @Published var model: String
    @Published var category: String
    @Published var madeIn: String
    @Published var finishStyle: String
    @Published var bodyShape: String
    @Published var dateMade: Date
    @Published var serialNumber: String
    @Published var electronics: String
    @Published var topMaterial: String
    @Published var sidesMaterial: String
    @Published var backMaterial: String
    @Published var neckMaterial: String
    @Published var neckShape: String
    @Published var purchaseDate: Date
    @Published var purchaseValue: Double
    @Published var purchasedFrom: String
    @Published var sold: Bool
    @Published var soldTo: String
    @Published var salesDate: Date
    @Published var salesValue: Double
    @Published var salesReason: String
    @Published var fretboardMaterial: String
    @Published var comments: String

    init(instrument: Instruments) {
        self.instrument = instrument

        // Initialize fields from the instrument object
        self.type = instrument.type ?? ""
        self.brand = instrument.brand ?? ""
        self.model = instrument.model ?? ""
        self.category = instrument.category ?? ""
        self.madeIn = instrument.madein ?? ""
        self.finishStyle = instrument.finishstyle ?? ""
        self.bodyShape = instrument.bodyshape ?? ""
        self.dateMade = instrument.datemanufactured ?? Date()
        self.serialNumber = instrument.serialnumber ?? ""
        self.electronics = instrument.electronics ?? ""
        self.topMaterial = instrument.topmaterial ?? ""
        self.sidesMaterial = instrument.sidesmaterial ?? ""
        self.backMaterial = instrument.backmaterial ?? ""
        self.neckMaterial = instrument.neckmaterial ?? ""
        self.neckShape = instrument.neckshape ?? ""
        self.purchaseDate = instrument.purchasedate ?? Date()
        self.purchaseValue = instrument.purchasevalue ?? 0.00
        self.purchasedFrom = instrument.purchasedfrom ?? ""
        self.sold = instrument.sold ?? false
        self.soldTo = instrument.soldto ?? ""
        self.salesDate = instrument.saledate ?? Date()
        self.salesValue = instrument.salevalue ?? 0.00
        self.salesReason = instrument.salereason ?? ""
        self.fretboardMaterial = instrument.fretboardmaterial ?? ""
        self.comments = instrument.comments ?? ""
    }

    func saveChanges() {
        // Update the instrument object with the edited values
        instrument.type = type
        instrument.brand = brand
        instrument.model = model
        instrument.category = category
        instrument.madein = madeIn
        instrument.finishstyle = finishStyle
        instrument.bodyshape = bodyShape
        instrument.datemanufactured = dateMade
        instrument.serialnumber = serialNumber
        instrument.electronics = electronics
        instrument.topmaterial = topMaterial
        instrument.sidesmaterial = sidesMaterial
        instrument.backmaterial = backMaterial
        instrument.neckmaterial = neckMaterial
        instrument.neckshape = neckShape
        instrument.purchasedate = purchaseDate
        instrument.purchasevalue = purchaseValue
        instrument.purchasedfrom = purchasedFrom
        instrument.sold = sold
        instrument.soldto = soldTo
        instrument.saledate = salesDate
        instrument.salevalue = salesValue
        instrument.salereason = salesReason
        instrument.fretboardmaterial = fretboardMaterial
        instrument.comments = comments
    }
}
