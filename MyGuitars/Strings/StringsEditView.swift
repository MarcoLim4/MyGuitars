import SwiftUI

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
                
                Section(header: Text("String")) {

                    HStack {
                        Text("Date Changed")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()
                        
                        DatePicker("Sale Date", selection: $date.onChange(updateValues), displayedComponents: .date)
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
                            .keyboardType(.decimalPad)
                    }

                    
                    HStack {
                        
                        Text("Price")
                            .font(.caption)
                            .foregroundColor(.gray)

                        
                        TextField("Price", value: $price.onChange(updateValues), formatter: formatter)
                            .font(.callout)
                            .keyboardType(.decimalPad)

                        
//                        TextField("Price", text: $price)
                    }

                    
                    // Life Span
//                    HStack {
//
////                        Text("Life Span in Months")
////                            .font(.caption)
////                            .foregroundColor(.gray)
//
//                        Picker("Life Span", selection: $lifespan.onChange(updateValues)) {
//                            ForEach(1 ..< 6) {
//                                Text("\($0)")
//                            }
//                        }
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                        .pickerStyle(SegmentedPickerStyle())
//                        .labelsHidden()
//
////                        TextField("Life span", text: $lifespan.onChange(updateValues))
////                            .font(.callout)
//                    }
                    
                    HStack {
                        
                        Text("Add Change Reminder?")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Toggle("", isOn: $changereminder.onChange(updateValues))
                        
                    }

                }
                .textCase(.none)
                
                Section {

                    Button("Delete String Details") {
                        isShowingDeleteMessage = true
                    }
                    .font(.headline)
                    .foregroundColor(.red)
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
//            .navigationTitle("String Details")
            .navigationBarTitle("String Details", displayMode: .inline)

        }
        
    }
        
    func updateValues() {
        
        stringSet.objectWillChange.send()
        instrument.objectWillChange.send()
        
        instrument.type = instrument.type
        
        stringSet.brand            = brand
        stringSet.gauge            = gauge
        stringSet.date             = date        
        stringSet.lifespan         = lifespan
        stringSet.myrating         = myrating
        stringSet.price            = price
        stringSet.remembertochange = changereminder
        stringSet.comments         = comments
        
        dataController.save()
        
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
