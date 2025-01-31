import SwiftUI

struct RepairsEditView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode)     var presentation
    @EnvironmentObject var dataController: DataController

    let repairs: Repairs
    let instrument: Instruments
    let formatter = NumberFormatter()

    @State private var isShowingDeleteMessage = false
    @State private var showsDatePicker = false

    @State private var repairedby: String
    @State private var repairtype: String
    @State private var dateperformed: Date
    @State private var repairrate: Int16
    @State private var comments: String
    @State private var cost: Double
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()


    init(repairs: Repairs, instrument: Instruments) {

        self.repairs  = repairs
        self.instrument = instrument

        _repairedby    = State(wrappedValue: repairs.repairedby ?? "")
        _repairtype    = State(wrappedValue: repairs.repairtype ?? "")
        _dateperformed = State(wrappedValue: repairs.dateperformed ?? Date())
        _repairrate    = State(wrappedValue: repairs.repairrate)
        _comments      = State(wrappedValue: repairs.comments ?? "")
        _cost          = State(wrappedValue: repairs.cost)

        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
    }

    var body: some View {

        NavigationView {

            Form {

                Section {

                    HStack {

                        Text("Date Performed")
                        Spacer()

                        DatePicker("", selection: $dateperformed, in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(CompactDatePickerStyle())
                            .frame(maxHeight: 400)

                        
                    }

                    HStack {
                        Text("Repair Type")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextField("Type", text: $repairtype.onChange(updateValues))
                            .font(.callout)
                    }

                    HStack {
                        Text("Repaired By")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextField("Repaired By", text: $repairedby.onChange(updateValues))
                            .font(.callout)
                    }

                    HStack {
                        Text("Cost")
                            .font(.caption)
                            .foregroundColor(.gray)

                        
                        NumberEntryField(value: self.$cost.onChange(updateValues))
                            .font(.callout)
                            .keyboardType(.decimalPad)
                    }

                    HStack {

                        Text("My Rating")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        RatingView(rating: $repairrate.onChange(updateValues))

                    }

                    VStack(alignment: .leading) {

                        Text("Comments")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextEditor(text: $comments.onChange(updateValues))
                            .font(.callout)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minHeight: 100)
                            .multilineTextAlignment(.leading)

                    }

                }
                
                Section {
                    
                    VStack(alignment: .center) {
                        
                        Button(action: {
                            print("Delete Repair Entry")
                            isShowingDeleteMessage.toggle()
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "trash")
                                Text("Delete Repair Entry")
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
                                title: Text("Delete this Repair?"),
                                message: Text("By confirming this action, it will permanently delete this repair entry."),
                                primaryButton: .destructive(Text("Yes! Delete it.")) {
                                    
                                    dataController.delete(repairs)
                                    self.presentation.wrappedValue.dismiss()
                                    
                                },
                                secondaryButton: .cancel()
                            )
                                
                        }

                    }

                }

            }
            .navigationBarTitle("Repair Details", displayMode: .large)
            .toolbar {
                
                Button("Close") {
                    withAnimation {
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                
            }


        }
    }

    func updateValues() {

        repairs.objectWillChange.send()
        instrument.objectWillChange.send()

        // If I remove this next line, I get no updates when the other screen appears
        // Need to figure out another way to update this, maybe using Combine. For now, this works.
        instrument.type = instrument.type

        repairs.repairedby     = repairedby
        repairs.repairtype     = repairtype
        repairs.dateperformed  = dateperformed
        repairs.repairrate     = repairrate
        repairs.cost           = cost
        repairs.comments       = comments
        
        repairs.instruments = instrument
                
    }

}

struct RepairsEditView_Previews: PreviewProvider {
    static var previews: some View {
        RepairsEditView(repairs: Instruments.repairSample, instrument: Instruments.example)
    }
}
