import Foundation
import CoreData
import SwiftUI

extension Instruments {
    
    var instType:   String { type ?? "Guitar" }
    var instBrand:  String { brand ?? "" }
    var instModel:  String { model ?? "" }

    static var allRecords: [Instruments] {
        return [Instruments]()        
    }

    static var example: Instruments {

        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let instrument = Instruments(context: viewContext)

        instrument.type              = "Acoustic"
        instrument.brand             = "Seagull"
        instrument.model             = "Maritime SWS Semi-Gloss"
        instrument.category          = "Dreadnought"
        instrument.madein            = "Canada"
        instrument.finishstyle       = "Semi-Gloss"
        instrument.rightleft         = 1 // 1-Right 2-Left
        instrument.numberofstrings   = 6
        instrument.sidesmaterial     = "Laminate"
        instrument.backmaterial      = "Laminate"
        instrument.fretboardmaterial = "Indian RoseWood"
        instrument.topmaterial       = "Solid Wood - Spruce"
        instrument.bodyshape         = "Dreadnought"
        instrument.electronics        = "Q1"
        instrument.datemanufactured  = Date()

        return instrument

    }

    static var photosSample: [Photos] {

        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        var someItems = [Photos]()

        for index in 1...7 {

            let newImage = Photos(context: viewContext)
            newImage.photo    = UIImage(named: "image0\(index).png")?.pngData()
            newImage.comments = "image \(index)"

            someItems.append(newImage)

        }
        return someItems as [Photos]

    }

    static var photoSample: Photos {

        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let newImage = Photos(context: viewContext)
        newImage.photo    = UIImage(named: "image05.png")?.pngData()
        newImage.comments = "Comments about image 05."

        return newImage

    }

    static var stringSample: Strings {

        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let newString = Strings(context: viewContext)

        newString.brand    = "Elixir"
        newString.gauge    = "Custom Light 10-47"
        newString.date     = Date()
        newString.comments = "Brand new set of strings"
        newString.lifespan = 1

        return newString

    }

    static var repairSample: Repairs {

        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let newRepair = Repairs(context: viewContext)

        newRepair.dateperformed = Date()
        newRepair.repairedby    = "Luthier Jimmy"
        newRepair.cost          = 45.99
        newRepair.comments      = "Perfect work"
        newRepair.repairrate    = 4
        newRepair.repairtype    = "Refret"
        
        return newRepair

    }

    // Also, to help cleat the code on the main views
    var allPhotos: [Photos] {
        let photosArray = photos?.allObjects as? [Photos] ?? []
        // Do any sorting here, if necessary
        return photosArray
    }

    var allRepairs: [Repairs] {
        let workArray = repairs?.allObjects as? [Repairs] ?? []
        return workArray
    }

    var allStrings: [Strings] {
        
        let stringsArray = strings?.allObjects as? [Strings] ?? []
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


    
}
