import SwiftUI

struct ContentView: View {
    
    var body: some View {

        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            InstrumentsView(showOnlyGuitars: false)
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
