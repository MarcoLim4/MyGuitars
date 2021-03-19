import SwiftUI

struct ContentView: View {
    
    @SceneStorage("selectedView") var selectedView: String?
    @EnvironmentObject var dataController: DataController
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {

        TabView(selection: $selectedView) {
            
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            InstrumentsView(dataController: dataController)
                .tag(InstrumentsView.tag)
                .tabItem {
                    Image("tabbar-instruments")
                    Text("Guitars")
                }

            StringsView(dataController: dataController)
                .tag(StringsView.tag)
                .tabItem {
                    Image("tabbar-strings")
                    Text("Strings")
                }

            RepairsView(dataController: dataController)
                .tag(RepairsView.tag)
                .tabItem {
                    Image("tabbar-repairs")
                    Text("Repairs")
                        .foregroundColor(.blue)
                }
            
        }
        .accentColor(.blue)

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
