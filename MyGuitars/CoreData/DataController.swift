import CoreData
import SwiftUI

class DataController: ObservableObject {

//    let container: NSPersistentCloudKitContainer
//    let appTransactionAuthor = "Defaut"
//
//    static var preview: DataController = {
//
//        let dataController = DataController(inMemory: true)
//        let viewContext = dataController.container.viewContext
//
//        do {
////            try dataController.createSampleData()
//        } catch {
//            fatalError("Fatal error creating preview: \(error.localizedDescription)")
//        }
//
//        return dataController
//    }()
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentCloudKitContainer(name: "Main")
//
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        }
//
//        // Enable history tracking and remote notifications
//        if let description = container.persistentStoreDescriptions.first {
//            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
//            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
//        }
//
//        container.loadPersistentStores { [weak self] storeDescription, error in
//
//            self?.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//            self?.container.viewContext.automaticallyMergesChangesFromParent = true
//            self?.container.viewContext.transactionAuthor = self?.appTransactionAuthor
//            try? self?.container.viewContext.setQueryGenerationFrom(.current)
//
//            if let error = error {
//                fatalError("Fatal error loading store: \(error.localizedDescription)")
//            }
//        }
//    }

//    func createSampleData() throws {
//
//        let viewContext = container.viewContext
//
//        for instrumentNumber in 1...2 {
//
//            let instruments = Instruments(context: viewContext)
//
//            instruments.type              = "Acoustic"
//            instruments.brand             = "Seagull"
//            instruments.model             = "Guitar Number \(instrumentNumber)"
//            instruments.category          = "Dreadnought"
//            instruments.madein            = "Canada"
//            instruments.finishstyle       = "Semi-Gloss"
//            instruments.rightleft         = 1 // 1-Right 2-Left
//            instruments.numberofstrings   = 6
//            instruments.sidesmaterial     = "Laminate"
//            instruments.backmaterial      = "Laminate"
//            instruments.fretboardmaterial = "Indian RoseWood"
//            instruments.topmaterial       = "Solid Wood - Spruce"
//            instruments.bodyshape         = "Dreadnought"
//            instruments.electronics       = "Q1"
//            instruments.datemanufactured  = Date()
//
//            instruments.photos = []
//
//            for photoNumber in 1...2 {
//
//                let photos = Photos(context: viewContext)
//
//                photos.comments = "Descripion \(photoNumber)"
//                let imageToSave = #imageLiteral(resourceName: "guitar")
//                photos.photo = imageToSave.pngData()
//
//                photos.instruments = instruments  // relationshtip
//
//            }
//
//        }
//
//        try viewContext.save()
//
//    }

//    func save() {
//        if container.viewContext.hasChanges {
//            try? container.viewContext.save()
//        }
//    }
//
//    func delete(_ object: NSManagedObject) {
//        container.viewContext.delete(object)
//    }
//
//    func deleteAll() {
//
//    }
//
//    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
//        (try? container.viewContext.count(for: fetchRequest)) ?? 0
//    }

}
