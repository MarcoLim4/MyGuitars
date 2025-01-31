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
                        Label("Add New Guitar".localized, systemImage: "plus.diamond")
                            .symbolRenderingMode(.palette)
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

//import SwiftUI
//import SwiftData
//
//struct InstrumentsView: View {
//
//    static let tag: String? = "Instruments".localized
//
//    @Environment(\.modelContext) private var context
//    @Query private var myInstruments: [Instruments]
//
//    @State private var showDeleteConfirmation = false
//    @State private var instrumentToDelete: Instruments?
//
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(myInstruments) { instrument in
//                    InstrumentsRow(instruments: instrument)
//                }
//                .onDelete { indexSet in
//                    if let index = indexSet.first {
//                        instrumentToDelete = myInstruments[index]
//                        showDeleteConfirmation = true
//                    }
//                }
//            }
//            .navigationTitle("Guitars".localized)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        createNewInstrument()
//                    } label: {
//                        Label("Add New Guitar".localized, systemImage: "plus.square")
//                    }
//                }
//            }
//            .confirmationDialog(
//                "Are you sure you want to delete this instrument?",
//                isPresented: $showDeleteConfirmation,
//                titleVisibility: .visible
//            ) {
//                Button("Delete", role: .destructive) {
//                    if let instrument = instrumentToDelete {
//                        withAnimation {
//                            deleteInstrument(instrument)
//                        }
//                    }
//                }
//                Button("Cancel", role: .cancel) { }
//            }
//        }
//    }
//
//    private func deleteInstrument(_ instrument: Instruments) {
//        context.delete(instrument)
//        instrumentToDelete = nil
//    }
//
//    private func createNewInstrument() {
//        let newInstrument = Instruments()
//        newInstrument.type = "Acoustic".localized
//        newInstrument.brand = "Brand Name"
//        context.insert(newInstrument)
//    }
//}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        InstrumentsView()
    }.modelContainer(previewContainer)
}

