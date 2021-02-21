import SwiftUI

struct InstrumentsRow: View {
    
    @ObservedObject var instrument: Instruments
    
    var body: some View {
        
        
        NavigationLink(destination: InstrumentsEditView(instrument: instrument)) {

            VStack(alignment: .leading) {
                
                Text(instrument.model ?? "")
                    .font(.headline)

                Text(instrument.brand ?? "")
                    .font(.footnote)
                    
            }
            .frame(height: 60)
            
        }

    }
}

struct InstrumentsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsRow(instrument: Instruments.example)
    }
}
