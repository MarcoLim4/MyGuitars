//
//  InstrumentsView.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-02-17.
//

import SwiftUI

struct InstrumentsView: View {
    
    static let tag: String? = "Instruments"
    let showOnlyGuitars: Bool
    let instruments: FetchRequest<Instruments>
    
    init(showOnlyGuitars: Bool) {
        
        // Not sure how we'll use this
        self.showOnlyGuitars = showOnlyGuitars

        instruments = FetchRequest<Instruments>(entity: Instruments.entity(),
                                                sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.datemanufactured,
                                                                                   ascending: true)],
                                                predicate: NSPredicate(format: "type != %@", "Guitars"))
    }
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(instruments.wrappedValue) { instrument in
                    
                    VStack(alignment: .leading) {
                        
                        Text(instrument.model ?? "")
                            .font(.headline)
                        
                        
                        Text(instrument.brand ?? "")
                            .font(.footnote)
                            
                    }
                    
                }

            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Guitars")
            
        }
        
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
