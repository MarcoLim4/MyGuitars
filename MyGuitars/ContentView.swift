import SwiftUI

struct ContentView: View {
    
    @SceneStorage("selectedView") var selectedView: String?
    
    var body: some View {

        TabView(selection: $selectedView) {
            
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            InstrumentsView()
                .tag(InstrumentsView.tag)
                .tabItem {
                    Image(systemName: "guitars")
                    Text("Guitars")
                }

            StringsView()
                .tag(StringsView.tag)
                .tabItem {
                    Image(systemName: "line.horizontal.3.circle")
                    Text("Strings")
                }

            WorkPerformedView()
                .tag(WorkPerformedView.tag)
                .tabItem {
                    Image(systemName: "squareshape.squareshape.dashed")
                    Text("Work Perfored")
                }

            
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
