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
//        myList.reminders = SampleData.Reminders
//        myList.allStrings
    }

    return container

}()

struct SampleData {

    static var myInstruments: [Instruments] {
        let instrument = Instruments(backmaterial: "Rosewood",
                                     bodyshape: "Slim",
                                     brand: "Ibanez",
                                     category: "Acoustic",
                                     comments: "",
                                     datemanufactured: Date(),
                                     electronics: "",
                                     finishstyle: "",
                                     fretboardmaterial: "Rosewood",
                                     madein: "Japan",
                                     model: "RG540",
                                     neckmaterial: "Rosewood",
                                     neckshape: "Conical",
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

//    static var Reminders: [Reminder] {
//        return [Reminder(title: "Reminder 1", notes: "This is reminder 1 notes!", reminderDate: Date(), remminderTime: Date()), Reminder(title: "Reminder 2", notes: "This is a reminder 2 note")]
//    }
}
