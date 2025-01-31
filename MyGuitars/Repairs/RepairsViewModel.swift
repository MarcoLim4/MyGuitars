import Foundation
import CoreData


extension RepairsView {
    
    class ViewModel: InstrumentsView.ViewModel {
        
        func addNewRepair(for instrument: Instruments) {

            let newRepair = Repairs(context: dataController.container.viewContext)

            newRepair.repairedby       = "Luthier"
            newRepair.repairtype       = "Type"
            newRepair.dateperformed    = Date()
            newRepair.repairrate       = 0
            newRepair.cost             = 0
            newRepair.comments         = ""
            newRepair.instruments      = instrument

            dataController.save()

        }
    }
}


