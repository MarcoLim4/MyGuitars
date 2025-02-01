//
//  PreviewContainer.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-30.
//

import Foundation
import SwiftData
import UIKit

@MainActor
var previewContainer: ModelContainer = {

    let container = try! ModelContainer(for: Instruments.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for myInstruments in SampleData.myInstruments {
        container.mainContext.insert(myInstruments)
        let sd = SampleData()
        myInstruments.strings = [sd.stringSample]
        myInstruments.repairs = [sd.repairSample]
        myInstruments.photos = sd.photosSample
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

    var stringSample: Strings {

        let newString = Strings()

        newString.brand    = "Elixir"
        newString.gauge    = "Custom Light 10-47"
        newString.date     = Date()
        newString.comments = "Brand new set of strings"
        newString.lifespan = 1

        return newString

    }

    var repairSample: Repairs {
        let newRepair = Repairs()
        newRepair.dateperformed = Date()
        newRepair.repairedby    = "Luthier Jimmy"
        newRepair.cost          = 45.99
        newRepair.comments      = "Perfect work"
        newRepair.repairrate    = 4
        newRepair.repairtype    = "Refret"
        return newRepair
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
}
