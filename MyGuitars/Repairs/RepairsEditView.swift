import SwiftUI

struct RepairsEditView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel: RepairsEditModel

    @State private var selectedRepair: Repairs
    @State private var isShowingDeleteMessage = false

    init(selectedRepair: Repairs) {
        self.selectedRepair = selectedRepair
        _viewModel = StateObject(wrappedValue: RepairsEditModel(repairs: selectedRepair))
    }

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    var body: some View {

        NavigationView {

            Form {

                Section {

                    HStack {

                        Text("Date Performed".localized)
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        DatePicker("", selection: $viewModel.dateperformed, in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(CompactDatePickerStyle())
                            .frame(maxHeight: 400)

                        
                    }

                    LabeledTextField(label: "Repair Type".localized, placeholder: "Repair Type".localized, text: $viewModel.repairtype)

                    LabeledTextField(label: "Repaired By".localized, placeholder: "Repaired By".localized, text: $viewModel.repairedby)


                    HStack {
                        Text("Cost".localized)
                            .font(.caption)
                            .foregroundColor(.gray)

                        DollarAmountEditor(amount: $viewModel.cost)
                    }

                    HStack {

                        Text("My Rating".localized)
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        RatingView(rating: $viewModel.repairrate)

                    }

                    VStack(alignment: .leading) {

                        Text("Comments".localized)
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
                    
                    VStack(alignment: .center) {
                        
                        Button(action: {
                            print("Delete Repair Entry".localized)
                            isShowingDeleteMessage.toggle()
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "trash")
                                Text("Delete Repair Entry".localized)
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
                                title: Text("Delete this Repair?".localized),
                                message: Text("By confirming this action, it will permanently delete this repair entry.".localized),
                                primaryButton: .destructive(Text("Yes! Delete it.".localized)) {
                                    context.delete(selectedRepair)
                                    presentation.wrappedValue.dismiss()
                                },
                                secondaryButton: .cancel()
                            )
                                
                        }

                    }

                }

            }
            .navigationBarTitle("Repair Details".localized, displayMode: .large)
            .toolbar {
                
                Button("Close".localized) {
                    withAnimation {
                        viewModel.saveChanges()
                        try? context.save()
                        dismiss()
                    }
                }
                
            }


        }
    }

}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        RepairsEditViewContainer()
    }.modelContainer(previewContainer)
}

struct RepairsEditViewContainer: View {

    var body: some View {
        RepairsEditView(selectedRepair: SampleData().repairSample)
    }
}

