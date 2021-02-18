import Foundation


extension Instruments {

    
    // This is to help avoid all the nil coalescing on the main ViewControllers
    
    var instType:   String { type ?? "Guitar" }
    var instBrand:  String { brand ?? "" }
    var instModel:  String { model ?? "" }
    
    
    
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
        instrument.eletronics        = "Q1"
        instrument.datemanufactured  = Date()
        
        return instrument
        
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
        let stringsArray = strings?.allObjects as? [Strings] ?? []
        return stringsArray
        
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
