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
    let instruments: FetchRequest<Instruments>
    
    init() {
        
        instruments = FetchRequest<Instruments>(entity: Instruments.entity(),
                                                sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.brand, ascending: true),
                                                                  NSSortDescriptor(keyPath: \Instruments.model, ascending: true)])

    }
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(instruments.wrappedValue) { instrument in
                    InstrumentsRow(instruments: instrument)

                }
                

            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Guitars")
            .toolbar {
                
                Button {
                    withAnimation {
                        
                        let newInstrument = Instruments(context: managedObjectContext)
                        newInstrument.type              = "Acoustic"
                        newInstrument.brand             = "New Guitar"
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
        InstrumentsView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
