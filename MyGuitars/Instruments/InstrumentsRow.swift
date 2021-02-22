import SwiftUI

struct InstrumentsRow: View {
    
    @ObservedObject var instruments: Instruments
    
    var body: some View {
        
        
        NavigationLink(destination: InstrumentsEditView(instrument: instruments)) {

            VStack(alignment: .leading) {
                
                Text(instruments.model ?? "")
                    .font(.headline)

                Text(instruments.brand ?? "")
                    .font(.footnote)
                    
            }
            .frame(height: 60)
            
        }

    }
}

struct InstrumentsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsRow(instruments: Instruments.example)
    }
}
