//
//  MyGuitarsApp.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-02-17.
//

import SwiftUI

@main
struct MyGuitarsApp: App {
        
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    // the two modifiers added to contentView is to make our dataController available to all views in the system
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
            
        }
    }
}
