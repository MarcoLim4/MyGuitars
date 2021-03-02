//
//  NumbersOnlyView.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-03-01.
//

import SwiftUI

class NumbersOnly: ObservableObject {
    
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
    
}

struct NumbersOnlyView: View {
    
    @ObservedObject var input = NumbersOnly()
       
    var body: some View {
        
       TextField("Value", text: $input.value)
           .padding()
           .keyboardType(.decimalPad)
    }
    
}

struct NumbersOnlyView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersOnlyView()
    }
}
