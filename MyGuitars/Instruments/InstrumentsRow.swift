import SwiftUI
import SwiftData

struct InstrumentsRow: View {
    
    var instruments: Instruments
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {

        NavigationLink(destination: InstrumentsEditView(selectedInstrument: instruments)) {

            HStack {

                switch instruments.type{
                case "Electric":
                    
                    Image("guitar-icon-electric")
                        .resizable()
                        .renderingMode(colorScheme == .dark ? .template : .original)
                        .colorMultiply(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)

                case "Ukelele":

                    Image("guitar-icon-ukelele")
                        .resizable()
                        .renderingMode(colorScheme == .dark ? .template : .original)
                        .colorMultiply(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                    
                case "Bass":
                    
                    Image("guitar-icon-bass")
                        .resizable()
                        .renderingMode(colorScheme == .dark ? .template : .original)
                        .colorMultiply(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                    
                case "Dulcimer":
                    
                    Image("guitar-icon-dulcimer")
                        .resizable()
                        .renderingMode(colorScheme == .dark ? .template : .original)
                        .colorMultiply(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                    
                default:
                    
                    Image("guitar-icon-acoustic")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                        .frame(width: 35, height: 35)
                }
                
                VStack(alignment: .leading) {
                    
                    Text(instruments.model ?? "Model")
                        .font(.headline)

                    Text(instruments.brand ?? "Brand")
                        .font(.footnote)
                        
                }
            }
            .frame(height: 60)
            
        }

    }

}

#if DEBUG
#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        InstrumentsRowContainer()
    }.modelContainer(previewContainer)
}

struct InstrumentsRowContainer: View {

    @Query(sort: \Instruments.serialnumber) private var instrument: [Instruments]

    var body: some View {
        InstrumentsRow(instruments: instrument[0])
    }
}
#endif
