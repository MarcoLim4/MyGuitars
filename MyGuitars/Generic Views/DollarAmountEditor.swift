//
//  DollarAmountEditor.swift
//  MyGuitars
//
//  Created by Marco Lima on 2025-01-31.
//

import SwiftUI

struct DollarAmountEditor: View {
    @Binding var amount: Double
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack {
                Text("$")
                    .font(.callout)
                    .foregroundStyle(.gray)

                TextField("0.00", value: $amount, format: .number.precision(.fractionLength(2)))
                    .font(.callout)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: amount) { _, newValue in
                        // Ensure non-negative value
                        if newValue < 0 {
                            amount = 0
                        }
                    }

                // Clear Button
                if amount > 0 {
                    Button(action: {
                        amount = 0
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
}

struct DollarAmountEditor_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var amount: Double = 1234.56
        var body: some View {
            DollarAmountEditor(amount: $amount)
        }
    }

    static var previews: some View {
        PreviewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
