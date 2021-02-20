//
//  InstrumentsView.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-02-17.
//

import SwiftUI

struct InstrumentsView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    static let tag: String? = "Instruments"
    let showOnlyGuitars: Bool
    let instruments: FetchRequest<Instruments>
    
    
    
    
    init(showOnlyGuitars: Bool) {
        
        // Not sure how we'll use this
        self.showOnlyGuitars = showOnlyGuitars

        instruments = FetchRequest<Instruments>(entity: Instruments.entity(),
                                                sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.datemanufactured,
                                                                                   ascending: true)])

        // I don/t need a filter as per PH's tutorial, so I just sort the data
//        instruments = FetchRequest<Instruments>(entity: Instruments.entity(),
//                                                sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.datemanufactured,
//                                                                                   ascending: true)],
//                                                predicate: NSPredicate(format: "type != %@", "Guitars"))
    }
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(instruments.wrappedValue) { instrument in
                    InstrumentsRow(instrument: instrument)
                }
                

            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Guitars")
            .toolbar {
                
                Button {
                    withAnimation {
                        
                        let newInstrument = Instruments(context: managedObjectContext)
                        newInstrument.type              = "Acoustic"
                        newInstrument.brand             = "Brand Name"
                        newInstrument.model             = "New Guitar"
                        newInstrument.rightleft         = 1 // 1-Right 2-Left
                        newInstrument.numberofstrings   = 6
                        
                        dataController.save()
                    }
                } label: {
                    Label("Add New Guitar", systemImage: "plus")
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct InstrumentsView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        InstrumentsView(showOnlyGuitars: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
