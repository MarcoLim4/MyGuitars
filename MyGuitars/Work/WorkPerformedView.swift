import SwiftUI

struct WorkPerformedView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showEditingScreen = false
    
    @FetchRequest(entity: Instruments.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.brand, ascending: true)]) var instruments: FetchedResults<Instruments>

    
    static let tag: String? = "Work"

    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(instruments) { instrument in

                    HStack {
                        StringsHeaderView(instrument: instrument)
                    }
                    
                    ForEach(instrument.allWork) { workDetails in

                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text(workDetails.kindofwork ?? "")
                                    .font(.headline)
                                    .foregroundColor(.blue)

                                Text(workDetails.comments ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                                
//                                Text(workDetails.cost ?? "")
//                                    .font(.footnote)
//                                    .foregroundColor(.blue)
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
//                        .sheet(isPresented: $showEditingScreen) {
//                            StringsEditView(stringSet: stringInfo, instrument: instrument)
//                        }
                        
                        
                    }
                    
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Work Performed")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
}

struct WorkPerformedView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        WorkPerformedView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
    
}
