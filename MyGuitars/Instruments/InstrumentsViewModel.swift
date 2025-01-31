import CoreData
import Foundation

extension InstrumentsView {
    
//    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
//        
//        let dataController: DataController
//        
//        private let instrumentsController: NSFetchedResultsController<Instruments>        
//        @Published var instruments = [Instruments]()
//        
//        init(dataController: DataController) {
//            
//            self.dataController = dataController
//            
//            let request: NSFetchRequest<Instruments> = Instruments.fetchRequest()
//            request.sortDescriptors = [NSSortDescriptor(keyPath: \Instruments.brand, ascending: true),
//                                       NSSortDescriptor(keyPath: \Instruments.model, ascending: true)]
//            
//            // leaving this here so we can use later if we need to filter somehow
////            request.predicate = NSPredicate(format: "criteria = filter", argument)
//            
//            instrumentsController = NSFetchedResultsController(fetchRequest: request,
//                                                               managedObjectContext: dataController.container.viewContext,
//                                                               sectionNameKeyPath: nil,
//                                                               cacheName: nil)
//            super.init()
//            instrumentsController.delegate = self
//            
//            do {
//                try instrumentsController.performFetch()
//                instruments = instrumentsController.fetchedObjects ?? []
//            } catch {
//                print("Error fetching instruments!!")
//            }
//            
//        }
//        
//        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//            if let newInstruments = controller.fetchedObjects as? [Instruments] {
//                instruments = newInstruments
//            }
//        }
//
//        func fetch() {
//            try? instrumentsController.performFetch()
//        }
//        
//        func addNewProject() {
//            
//            let newInstrument = Instruments(context: dataController.container.viewContext)
//            
//            newInstrument.type              = "Acoustic".localized
//            newInstrument.brand             = "New Guitar".localized
//            newInstrument.model             = "New Guitar".localized
//            newInstrument.rightleft         = 1 // 1-Right 2-Left
//            newInstrument.numberofstrings   = 6
//            
//            dataController.save()
//
//        }
//
//    }
}
