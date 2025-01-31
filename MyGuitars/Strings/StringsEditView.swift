import SwiftUI
import SwiftData
//import Combine

struct StringsEditView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentation

    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel: StringsEditModel

    @State private var selectedStringSet: Strings
    @State private var isShowingDeleteMessage = false

    let formatter = NumberFormatter()

    init(selectedStringSet: Strings) {
        self.selectedStringSet = selectedStringSet
        _viewModel = StateObject(wrappedValue: StringsEditModel(strings: selectedStringSet))
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
    }

    var body: some View {

        NavigationView {

            Form {

                Section {

                    HStack {
                        Text("Date Changed")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        DatePicker("Select Date", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(CompactDatePickerStyle())
                            .frame(maxHeight: 400)
                    }

                    LabeledTextField(label: "Brand".localized, placeholder: "Brand".localized, text: $viewModel.brand)
                    LabeledTextField(label: "Gauge".localized, placeholder: "Gauge".localized, text: $viewModel.gauge)

                    HStack {
                        Text("Purchase Value")
                            .font(.caption)
                            .foregroundColor(.gray)

                        DollarAmountEditor(amount: $viewModel.price)
                    }


                    HStack {

                        Text("Life Span in Months")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        LifeSpanView(lifespan: $viewModel.lifespan)

                    }

                    HStack {

                        Text("My Rating")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        RatingView(rating: $viewModel.myrating)

                    }

                    VStack(alignment: .leading) {

                        Text("Comments")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextEditor(text: $viewModel.comments)
                            .font(.callout)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minHeight: 100)
                            .multilineTextAlignment(.leading)
                    }

                }
                .textCase(.none)

                Section {

                    Button(action: {
                        isShowingDeleteMessage.toggle()
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "trash")
                            Text("Delete String Details")
                                .font(.system(size: 16, weight: .regular, design: .default))
                        }
                    }
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 45,
                           maxHeight: 45,
                           alignment: .center)
                    .font(.headline)
                    .foregroundColor(.red)
                    .font(.headline)
                    .alert(isPresented: $isShowingDeleteMessage) {

                        Alert(
                            title: Text("Delete this strings set?"),
                            message: Text("By confirming this action, it will permanently delete this strings set."),
                            primaryButton: .destructive(Text("Yes! Delete it.")) {
                                context.delete(selectedStringSet)
                                presentation.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel()
                        )

                    }

                }

            }
            .navigationBarTitle("String Details", displayMode: .inline)
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveChanges()
                        try? context.save()
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
            }
        }

    }

}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        StringsEditViewContainer()
    }.modelContainer(previewContainer)
}

struct StringsEditViewContainer: View {

    var body: some View {
        StringsEditView(selectedStringSet: Instruments().stringSample)
    }
}

