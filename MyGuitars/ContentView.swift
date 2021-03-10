import SwiftUI

struct ContentView: View {
    
    @SceneStorage("selectedView") var selectedView: String?
    @EnvironmentObject var dataController: DataController
    
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
                    Image(systemName: "guitars")
                    Text("Guitars")
                }

            StringsView(dataController: dataController)
                .tag(StringsView.tag)
                .tabItem {
                    Image(systemName: "line.horizontal.3.circle")
                    Text("Strings")
                }

            RepairsView()
                .tag(RepairsView.tag)
                .tabItem {
                    Image(systemName: "squareshape.squareshape.dashed")
                    Text("Repairs")
                }
            
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
