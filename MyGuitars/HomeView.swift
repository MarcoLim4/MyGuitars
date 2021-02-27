import SwiftUI

struct HomeView: View {
    
    static let tag: String? = "Home"
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        
        NavigationView {

            Form {

                Section {
                    Button("Clear DB and Add Sample Data") {
                        dataController.deleteAll()
                        try? dataController.createSampleData()
                    }
                }
                
                Section {
                    Button("Delete All Data") {
                        dataController.deleteAll()
                        dataController.save()
                    }
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
