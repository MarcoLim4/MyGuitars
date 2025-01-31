//
//  PreviewContainer.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-30.
//

import Foundation
import SwiftData

@MainActor
var previewContainer: ModelContainer = {

    let container = try! ModelContainer(for: Instruments.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for myInstruments in SampleData.myInstruments {
        container.mainContext.insert(myInstruments)
        myInstruments.strings = [SampleData.stringSample]
        myInstruments.repairs = [SampleData.repairSample]
    }

    return container

}()

struct SampleData {

    static var myInstruments: [Instruments] {
        let instrument = Instruments(backmaterial: "Rosewood",
                                     bodyshape: "Slim",
                                     brand: "Martin",
                                     category: "Acoustic",
                                     comments: "",
                                     datemanufactured: Date(),
                                     electronics: "",
                                     finishstyle: "",
                                     fretboardmaterial: "Rosewood",
                                     madein: "Mexico",
                                     model: "M-36e",
                                     neckmaterial: "Rosewood",
                                     neckshape: "C-Shape",
                                     numberoffrets: 24,
                                     numberofstrings: 6,
                                     purchasedate: Date(),
                                     purchasedfrom: "",
                                     purchasevalue: 0.0,
                                     rightleft: 0,
                                     saledate: Date(),
                                     salereason: "",
                                     salevalue: 0.0,
                                     serialnumber: "",
                                     sidesmaterial: "Rosewood")

        return [instrument]
    }

    static var stringSample: Strings {

        let newString = Strings()

        newString.brand    = "Elixir"
        newString.gauge    = "Custom Light 10-47"
        newString.date     = Date()
        newString.comments = "Brand new set of strings"
        newString.lifespan = 1

        return newString

    }

    static var repairSample: Repairs {
        let newRepair = Repairs()
        newRepair.dateperformed = Date()
        newRepair.repairedby    = "Luthier Jimmy"
        newRepair.cost          = 45.99
        newRepair.comments      = "Perfect work"
        newRepair.repairrate    = 4
        newRepair.repairtype    = "Refret"
        return newRepair
    }
}
