import Foundation
import CoreData
import SwiftUI


extension Instruments {
    
    // This is to help avoid all the nil coalescing on the main ViewControllers
    
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
    
    
    // Also, to help cleat the code on the main views
    var allPhotos: [Photos] {
        let photosArray = photos?.allObjects as? [Photos] ?? []
        // Do any sorting here, if necessary
        return photosArray
    }
    
    var allWork: [WorkPerformed] {
        let workArray = work?.allObjects as? [WorkPerformed] ?? []
        return workArray
    }
    
    var allStrings: [Strings] {
        
        #warning("need to revisit this sorting")
        let stringsArray = strings?.allObjects as? [Strings] ?? []
        return stringsArray.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
        
    }
    
    
//MARK: - Helpers
    
    var instrumentTypes: [String] {
        let types = ["Acoustic", "Electric", "Bass", "Ukelele", "Merlin"]
        return types.sorted()
    }
    
    var acosuticBodyTypes: [String] {
        let types = ["Dreadnought", "Parlour", "Jumbo", "Auditorium", "Grand Auditorium", "Classical", "Traveler", "Mini", "Tenor", "Orchestra Model"]
        return types.sorted()
    }
    
    var electricBodyTypes: [String] {
        
        let types = ["Les Paul", "Telecaster", "Stratocaster", "RG", "SG", "ES-45"]
        return types.sorted()

    }
    
}
