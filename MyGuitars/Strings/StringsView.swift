import SwiftUI

struct StringsView: View {

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var showEditingScreen = false

    let instruments: FetchRequest<Instruments>
    static let tag: String? = "Strings"

    init() {

        instruments = FetchRequest<Instruments>(entity: Instruments.entity(),
                                                sortDescriptors: [NSSortDescriptor(keyPath: \Instruments.brand, ascending: true),
                                                                  NSSortDescriptor(keyPath: \Instruments.model, ascending: true)])

    }

    var body: some View {

        NavigationView {

            List {

                ForEach(instruments.wrappedValue) { instrument in

                    // This was on StringsHeaderView but was not refreshing instruments properly
                    HStack {

                        Text("\(instrument.instModel)")
                            .font(.headline)

                        Spacer()

                        Button(action: {
                            addString(for: instrument)
                        }, label: {
                            Label(
                                title: { Text("") },
                                icon: { Image(systemName: "plus.square")
                                    .foregroundColor(.blue)
                                }
                            )

                        })

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

                                Text(stringInfo.date?.toString() ?? "")
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
                            StringsEditView(stringSet: stringInfo, instrument: instrument)
                        }

                    }

                }

            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Strings")

        }
        .navigationViewStyle(StackNavigationViewStyle())

    }

    func addString(for instrument: Instruments) {

        let newString = Strings(context: managedObjectContext)

        newString.brand       = "New String Set"
        newString.gauge       = ""
        newString.date        = Date()
        newString.lifespan    = 0
        newString.myrating    = 0
        newString.price       = 0
        newString.comments    = ""
        newString.instruments = instrument

        dataController.save()

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
