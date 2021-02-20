//
//  HomeView.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-02-17.
//

import SwiftUI

struct HomeView: View {
    
    static let tag: String? = "Home"
    @EnvironmentObject var dataController: DataController
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
