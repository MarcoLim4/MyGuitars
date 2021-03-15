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
                    
                    Text(instruments.model ?? "")
                        .font(.headline)

                    Text(instruments.brand ?? "")
                        .font(.footnote)
                        
                }
            }
            .frame(height: 60)
            
        }

    }
    
//    func imageHead(imageName: String) -> Image {
//
//        if colorScheme == .dark {
//            return Image(imageName)
//                .resizable()
//                .colorMultiply(.white)
//        }
//
//        return Image(imageName)
//            .resizable()
//
//    }
    
}

struct InstrumentsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsRow(instruments: Instruments.example)
    }
}
