//
//  StringsHeaderView.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-02-23.
//

import SwiftUI

struct StringsHeaderView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    let instrument: Instruments
    
    var body: some View {
    
        HStack {
            
            Text("\(instrument.instModel)")
                .font(.headline)

            Spacer()

            Button(action: {
                addString(for: instrument)
            }, label: {
                Label(
                    title: { Text("") },
                    icon: { Image(systemName: "plus")
                        .foregroundColor(.blue)
                    }
                )

            })
            
        }
    
    }
    
    func addString(for instrument: Instruments) {
        
        let newString = Strings(context: managedObjectContext)
        
        newString.brand       = "New String Set"
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

struct StringsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StringsHeaderView(instrument: Instruments.example)
    }
}
