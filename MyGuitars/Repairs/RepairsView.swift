import SwiftUI
import SwiftData

struct RepairsView: View {

    static let tag: String? = "Repairs"

    @Environment(\.colorScheme) var colorScheme
    @State private var showEditingScreen = false

    @Environment(\.modelContext) private var context
    @Query private var myInstruments: [Instruments]

    @State private var selectedRepair: Repairs?

    var body: some View {

        NavigationView {

            List {

                ForEach(myInstruments) { instrument in

                    HStack {

                        InstrumentIconView(instrumentType: instrument.type)

                        VStack(alignment: .leading) {

                            Text("\(instrument.brand ?? "")")
                                .font(.system(size: 14, weight: .light, design: .rounded))

                            Text("\(instrument.model ?? "")")
                                .font(.system(size: 16, weight: .semibold, design: .default))

                        }

                        Spacer()

                        Button(action: {
                            withAnimation {
                                addRepair(for: instrument)
                            }
                        }, label: {
                            Label(
                                title: { Text("") },
                                icon: {
                                    Image(systemName: "plus.app.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                        .padding(.leading, 32)
                                }
                            )

                        })

                    }

                    ForEach(instrument.allRepairs) { repair in

                        HStack {

                            VStack(alignment: .leading) {

                                Image("guitar-repairs")
                                    .resizable()
                                    .renderingMode(.template) // Enables color tinting
                                    .foregroundColor(colorScheme == .dark ? .white : .black) // Changes image color
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30, alignment: .leading)
                                    .clipShape(Circle()) // Ensures circular shape
                                    .overlay(
                                        Circle()
                                            .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 0.75)
                                    )


                            }

                            VStack(alignment: .leading) {

                                Text(repair.repairtype ?? "")
                                    .font(.system(size: 14, weight: .bold, design: .default))

                                Text(repair.repairedby ?? "")
                                    .font(.system(size: 13, weight: .thin, design: .default))

                            }
                            .padding(.leading, 8)

                            Spacer()

                            Button(action: {
                                showEditingScreen.toggle()
                                DispatchQueue.main.async {
                                    self.selectedRepair = repair
                                }
                            }, label: {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            })

                        }
                        .padding(.leading, 40)
                        .padding(.top)
                        .padding(.bottom)
                        .sheet(item: $selectedRepair) { repair in
                            RepairsEditView(selectedRepair: repair)
                        }

                    }

                }

            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Repairs".localized)

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func addRepair(for instrument: Instruments) {
        let newRepair = Repairs()
        newRepair.dateperformed = Date()
        newRepair.repairedby    = "Luthier"
        newRepair.cost          = 0.00
        newRepair.comments      = ""
        newRepair.repairrate    = 0
        newRepair.repairtype    = "Repair Type"
        newRepair.instruments = instrument
        context.insert(newRepair)

    }

}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        RepairsView()
    }.modelContainer(previewContainer)
}
