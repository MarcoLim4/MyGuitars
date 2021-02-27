// Solution suggested by Paul Hudson.
// Makes the code a little better to read on the main views.

import SwiftUI

extension Binding {
    
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
        
    }
    
}

