import CoreData
import SwiftUI

class DataController: ObservableObject {
    
    let container: NSPersistentCloudKitContainer
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext

        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }

        return dataController
    }()
    
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    func createSampleData() throws {
        
        let viewContext = container.viewContext
        
        
        for i in 1...2 {
            
            let instruments = Instruments(context: viewContext)
            
            instruments.type              = "Guitar"
            instruments.brand             = "Seagull"
            instruments.model             = "Guitar Number \(i)"
            instruments.category          = "Dreadnought"
            instruments.madein            = "Canada"
            instruments.finishstyle       = "Semi-Gloss"
            instruments.rightleft         = 1 // 1-Right 2-Left
            instruments.numberofstrings   = 6
            instruments.sidesmaterial     = "Laminate"
            instruments.backmaterial      = "Laminate"
            instruments.fretboardmaterial = "Indian RoseWood"
            instruments.topmaterial       = "Solid Wood - Spruce"
            instruments.bodyshape         = "Dreadnought"
            instruments.eletronics        = "Q1"
            instruments.datemanufactured  = Date()

            instruments.photos = []
            
            for j in 1...2 {
                
                let photos = Photos(context: viewContext)
                
                photos.comments = "Descripion \(j)"
                let imageToSave = #imageLiteral(resourceName: "guitar")
                photos.photo = imageToSave.pngData()
                
                photos.instruments = instruments  // relationshtip
                
            }
            
            
        }

        try viewContext.save()
        
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Photos.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)

        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Instruments.fetchRequest()
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? container.viewContext.execute(batchDeleteRequest2)
    }
    
    
}
