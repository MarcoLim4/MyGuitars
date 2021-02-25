import SwiftUI

struct StringsView: View {

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    static let tag: String? = "Strings"
//    let instruments: FetchRequest<Instruments>
    
    @State private var showEditingScreen = false
    
    @FetchRequest(entity: Instruments.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.brand, ascending: true)]) var instruments: FetchedResults<Instruments>
    
    
//    init() {
//
////        instruments = FetchRequest<Instruments>(entity: Instruments.entity(),
////                                                sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.brand, ascending: true),
////                                                                  NSSortDescriptor(keyPath: \Instruments.model, ascending: true)])
//
//    }
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(instruments) { instrument in

                    HStack {
                        StringsHeaderView(instrument: instrument)
                    }
                    
                    ForEach(instrument.allStrings) { stringInfo in

                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text(stringInfo.brand ?? "")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                Text(stringInfo.gauge ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()

                            Button(action: {
                                self.showEditingScreen.toggle()
                            }, label: {
                                Image(systemName: "pencil.circle")
                                    .foregroundColor(.blue)
                            })
                            
                        }
                        .padding()
                        .sheet(isPresented: $showEditingScreen) {
                            StringsEditView(stringSet: stringInfo, instrument: instrument)
                        }
                        
                        
                    }
                    
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Strings History")

            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct StringsView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        StringsView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
        
}
