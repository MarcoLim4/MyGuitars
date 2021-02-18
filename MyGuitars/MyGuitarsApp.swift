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
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save)
            
        }
    }
    
    // Every time the app goes into background mode, we save the data
    func save(_ note: Notification) {
        dataController.save()
    }
    
}
