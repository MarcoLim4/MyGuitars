import SwiftUI

struct RepairsView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showEditingScreen = false
    
    @FetchRequest(entity: Instruments.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.brand, ascending: true),
                                    NSSortDescriptor(keyPath: \Instruments.model, ascending: true)]) var instruments: FetchedResults<Instruments>

    
    static let tag: String? = "Repairs"

    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(instruments) { instrument in

                    HStack {
//                        StringsHeaderView(instrument: instrument)
                        Text("\(instrument.instModel)")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: {
                            addNewRepair(for: instrument)
                        }, label: {
                            Label(
                                title: { Text("") },
                                icon: { Image(systemName: "plus.square")
                                    .foregroundColor(.blue)
                                }
                            )

                        })

                    }
                    
                    ForEach(instrument.allRepairs) { repairs in

                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text(repairs.repairtype ?? "")
                                    .font(.headline)
                                    .foregroundColor(.blue)

                                Text(repairs.repairedby ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                                
                            }
                            
                            Spacer()

                            Button(action: {
                                self.showEditingScreen.toggle()
                            }, label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            })
                            
                        }
                        .padding()
                        .sheet(isPresented: $showEditingScreen) {
                            RepairsEditView(repairs: repairs, instrument: instrument)
                        }
                        
                        
                    }
                    
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Repairs")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func addNewRepair(for instrument: Instruments) {

        let newRepair = Repairs(context: managedObjectContext)
        
        newRepair.repairedby       = "Luthier"
        newRepair.repairtype       = "Type"
        newRepair.dateperformed    = Date()
        newRepair.repairrate       = 0
        newRepair.cost             = 0
        newRepair.comments         = ""
        newRepair.instruments      = instrument
        
        dataController.save()
        
    }
    
}

struct WorkPerformedView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        RepairsView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
    
}
