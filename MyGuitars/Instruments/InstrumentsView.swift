import SwiftUI
import SwiftData

struct InstrumentsView: View {

    static let tag: String? = "Instruments".localized

    @Environment(\.modelContext) private var context
    @Query private var myInstruments: [Instruments]

    @State private var instrumentToDelete: Instruments?

    var body: some View {

        NavigationView {

            List {
                ForEach(myInstruments) { instrument in
                    InstrumentsRow(instruments: instrument)
                }
                .onDelete(perform: deleteInstruments)

            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        createNewInstrument()
                    } label: {
                        Label("Add New Guitar".localized, systemImage: "plus.app.fill")
                    }
                }
            }
            .navigationTitle("Guitars")
            .navigationBarTitleDisplayMode(.large)

        }
        .refreshable {
            // Not sure if we need a pull down to resfresh
        }

    }

    private func deleteInstruments(_ indexSet: IndexSet) {
        guard let index = indexSet.last else { return }
        let instrumentToDelete = myInstruments[index]
        context.delete(instrumentToDelete)
    }

    private func createNewInstrument() {
        let newInstrument = Instruments()
        newInstrument.type = "Acoustic".localized
        newInstrument.brand = "Brand Name"
        newInstrument.model = "Model Name"
        context.insert(newInstrument)
    }

}

#if DEBUG
#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        InstrumentsView()
    }.modelContainer(previewContainer)
}
#endif
