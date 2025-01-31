import SwiftUI
import SwiftData

struct StringsView: View {
    
    static let tag: String? = "Strings"

    @Environment(\.colorScheme) var colorScheme
    @State private var showEditingScreen = false

    @Environment(\.modelContext) private var context
    @Query private var myInstruments: [Instruments]

    @State private var selectedStringSet: Strings?

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
                                addString(for: instrument)
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

                    // All the Strings
                    ForEach(instrument.allStrings) { stringInfo in

                        HStack {

                            VStack(alignment: .leading) {

                                Image("guitar-strings")
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

                                Text(stringInfo.brand ?? "")
                                    .font(.system(size: 14, weight: .bold, design: .default))

                                Text(stringInfo.gauge ?? "")
                                    .font(.system(size: 13, weight: .thin, design: .default))

                                Text(stringInfo.date?.toString() ?? "")
                                    .font(.system(size: 12, weight: .medium, design: .default))

                            }
                            .padding(.leading, 8)

                            Spacer()

                            Button(action: {
                                DispatchQueue.main.async {
                                    self.selectedStringSet = stringInfo
                                }
                            }, label: {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            })

                        }
                        .padding(.leading, 40)
                        .sheet(item: $selectedStringSet) { selectedString in
                            StringsEditView(selectedStringSet: selectedString)
                        }

                    }

                }

            }
            .navigationTitle("Strings".localized)
            .navigationBarTitleDisplayMode(.large)

        }
        .navigationViewStyle(StackNavigationViewStyle())

    }

    func addString(for instrument: Instruments) {
        let newString = Strings()
        newString.brand       = "New String Set".localized
        newString.gauge       = "Gauge"
        newString.date        = Date()
        newString.lifespan    = 0
        newString.myrating    = 0
        newString.price       = 0
        newString.comments    = ""
        newString.instruments = instrument  // Relationship
        context.insert(newString)
    }


}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        StringsView()
    }.modelContainer(previewContainer)
}


struct InstrumentIconView: View {
    let instrumentType: String?
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Image(iconName(for: instrumentType ?? "Acoustic"))
            .resizable()
            .renderingMode(colorScheme == .dark ? .template : .original)
            .colorMultiply(.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 35, height: 35)
    }

    private func iconName(for type: String) -> String {
        switch type {
        case "Electric":
            return "guitar-icon-electric"
        case "Ukelele":
            return "guitar-icon-ukelele"
        case "Bass":
            return "guitar-icon-bass"
        case "Dulcimer":
            return "guitar-icon-dulcimer"
        default:
            return "guitar-icon-acoustic"
        }
    }
}
