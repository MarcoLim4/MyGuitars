import SwiftUI
import Combine

struct StringsEditView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode)     var presentation
    @EnvironmentObject var dataController: DataController

    let stringSet: Strings
    let instrument: Instruments
    let formatter = NumberFormatter()

    @State private var isShowingDeleteMessage = false

    @State private var brand: String
    @State private var gauge: String
    @State private var date: Date
    @State private var lifespan: Int16
    @State private var myrating: Int16
    @State private var price: Double
    @State private var changereminder: Bool
    @State private var comments: String

    init(stringSet: Strings, instrument: Instruments) {

        self.stringSet  = stringSet
        self.instrument = instrument

        _brand          = State(wrappedValue: stringSet.brand ?? "")
        _gauge          = State(wrappedValue: stringSet.gauge ?? "")
        _date           = State(wrappedValue: stringSet.date ?? Date())
        _lifespan       = State(wrappedValue: stringSet.lifespan)
        _myrating       = State(wrappedValue: stringSet.myrating)
        _price          = State(wrappedValue: stringSet.price)
        _changereminder = State(wrappedValue: stringSet.remembertochange)
        _comments       = State(wrappedValue: stringSet.comments ?? "")

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

                        DatePicker("Sale Date", selection: $date.onChange(updateValues), in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(CompactDatePickerStyle())
                            .frame(maxHeight: 400)
                    }

                    HStack {
                        Text("Brand")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextField("Brand", text: $brand.onChange(updateValues))
                            .font(.callout)
                    }

                    HStack {
                        Text("Gauge")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextField("Gauge", text: $gauge.onChange(updateValues))
                            .font(.callout)
                            
                    }

                    HStack {

                        Text("Price")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        NumberEntryField(value: self.$price.onChange(updateValues))
                            .font(.callout)
                            .keyboardType(.decimalPad)
                    }

                    HStack {

                        Text("Life Span in Months")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        LifeSpanView(lifespan: $lifespan.onChange(updateValues))

                    }

                    HStack {

                        Text("My Rating")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                        RatingView(rating: $myrating.onChange(updateValues))

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
                .textCase(.none)

                Section {

                    Button(action: {
                        isShowingDeleteMessage.toggle()
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "minus.circle")
                            Text("Delete String Details")
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

                                dataController.delete(stringSet)
                                self.presentation.wrappedValue.dismiss()

                            },
                            secondaryButton: .cancel()
                        )

                    }

                }

            }
            .navigationBarTitle("String Details", displayMode: .automatic)
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

        print("Price of String Set : \(price)")
        print("Life space of Set   : \(lifespan)")

        stringSet.objectWillChange.send()
        instrument.objectWillChange.send()

        // If I remove this next line, I get no updates when the other screen appears
        // Need to figure out another way to update this, maybe using Combine. For now, this works.
        instrument.type = instrument.type

        stringSet.brand            = brand
        stringSet.gauge            = gauge
        stringSet.date             = date        
        stringSet.lifespan         = lifespan
        stringSet.myrating         = myrating
        stringSet.price            = price
        stringSet.remembertochange = changereminder
        stringSet.comments         = comments
        
        stringSet.instruments = instrument

//        #warning("This cannot be here but if I added it to te OnDisappear, it crashes")
//        dataController.save()
    }

}

struct StringsEditView_Previews: PreviewProvider {

    static var dataController = DataController.preview

    static var previews: some View {
        StringsEditView(stringSet: Instruments.stringSample, instrument: Instruments.example)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }

}
