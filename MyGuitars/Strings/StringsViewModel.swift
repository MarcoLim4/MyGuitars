import Foundation
import CoreData


extension StringsView {
    
    class ViewModel: InstrumentsView.ViewModel {

        func addString(for instrument: Instruments) {

            let newString = Strings(context: dataController.container.viewContext)

            newString.brand       = "New String Set".localized
            newString.gauge       = ""
            newString.date        = Date()
            newString.lifespan    = 0
            newString.myrating    = 0
            newString.price       = 0
            newString.comments    = ""
            newString.instruments = instrument

            dataController.save()

        }
        
    }
}

extension StringsEditView {
    class ViewModel: InstrumentsView.ViewModel {
        
        
    }
    
}
