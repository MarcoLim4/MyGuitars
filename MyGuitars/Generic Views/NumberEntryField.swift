import SwiftUI
import Combine

struct NumberEntryField : View {
    
    @State private var enteredValue: String = ""
    @Binding var value: Double

    var body: some View {
        
        return TextField("", text: $enteredValue)
            .onReceive(Just(enteredValue)) { typedValue in
                
                if let newValue = Double(typedValue) {
                    self.value = newValue
                }
                
            }.onAppear(perform:{
                
                self.enteredValue = "\(self.value)"
                
            })
    }
    
}
