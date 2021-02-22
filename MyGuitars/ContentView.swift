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

            
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
