import SwiftUI
import SwiftData

@main
struct MyGuitarsApp: App {
        
    init() {
//        let dataController = DataController()
//        _dataController = StateObject(wrappedValue: dataController)
    }
    
    // the two modifiers added to contentView is to make our dataController available to all views in the system
    var body: some Scene {
        
        WindowGroup {
            NavigationStack {
                ContentView()
            }.modelContainer(for: [Instruments.self, Photos.self, Repairs.self, Strings.self])
        }

    }
    
    // Every time the app goes into background mode, we save the data
    func save(_ note: Notification) {
//        dataController.save()
    }
    
}
#warning("Need to review this code! Maybe create a context to save data whenever the app closes or goes into background mode. Might need a SceneDelegate")
