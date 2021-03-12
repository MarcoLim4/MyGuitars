import SwiftUI

struct InstrumentsRow: View {
    
    @ObservedObject var instruments: Instruments
    
    var body: some View {
                
        NavigationLink(destination: InstrumentsEditView(instrument: instruments)) {

            HStack {

                switch instruments.type{
                case "Electric":
                    Image("guitar-icon-electric")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                case "Ukelele":
                    Image("guitar-icon-ukelele")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                case "Bass":
                    Image("guitar-icon-bass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                case "Dulcimer":
                    Image("guitar-icon-dulcimer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                default:
                    Image("guitar-icon-acoustic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                }
                
                VStack(alignment: .leading) {
                    
                    Text(instruments.model ?? "")
                        .font(.headline)

                    Text(instruments.brand ?? "")
                        .font(.footnote)
                        
                }
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
