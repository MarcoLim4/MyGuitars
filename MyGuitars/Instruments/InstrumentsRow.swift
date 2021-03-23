import SwiftUI

struct InstrumentsRow: View {
    
    @ObservedObject var instruments: Instruments
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
                
        NavigationLink(destination: InstrumentsEditView(instrument: instruments)) {

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
                        .renderingMode(colorScheme == .dark ? .template : .original)
                        .colorMultiply(.white)
                        .aspectRatio(contentMode: .fit)
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

struct InstrumentsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsRow(instruments: Instruments.example)
    }
}
