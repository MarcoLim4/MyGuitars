import SwiftUI
import Foundation
import UIKit

struct InstrumentsEditView: View {

    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var imagePickerSource = PhotoSource.library
    @State private var inputImage: UIImage?

    let instrument: Instruments

    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentation

    @State private var isShowingDeleteMessage = false

    //MARK: Data

    @State private var type: String
    @State private var brand: String
    @State private var model: String
    @State private var category: String
    @State private var madeIn: String
    @State private var finishStyle: String
    @State private var bodyShape: String

    @State private var dateMade: Date
    @State private var serialNummber: String

    @State private var electronics: String
    @State private var topMaterial: String
    @State private var sidesMaterial: String
    @State private var backMaterial: String
    @State private var neckMaterial: String
    @State private var neckShape: String

    @State private var purchaseDate: Date
    @State private var purchaseValue: Double
    @State private var purchasedfrom: String
    
    @State private var sold: Bool
    @State private var soldto: String
    @State private var salesDate: Date
    @State private var salesValue: Double
    @State private var salesreason: String
    
    @State private var fretboardMaterial: String
    @State private var comments: String

    init(instrument: Instruments) {

        self.instrument = instrument

        _type              = State(wrappedValue: instrument.type ?? "")
        _brand             = State(wrappedValue: instrument.instBrand)
        _model             = State(wrappedValue: instrument.instModel)
        _category          = State(wrappedValue: instrument.category ?? "")
        _madeIn            = State(wrappedValue: instrument.madein ?? "")
        _finishStyle       = State(wrappedValue: instrument.finishstyle ?? "")
        _bodyShape         = State(wrappedValue: instrument.bodyshape ?? "")
        _dateMade          = State(wrappedValue: instrument.datemanufactured ?? Date())
        _serialNummber     = State(wrappedValue: instrument.serialnumber ?? "")
        _electronics       = State(wrappedValue: instrument.electronics ?? "")
        _topMaterial       = State(wrappedValue: instrument.topmaterial ?? "")
        _sidesMaterial     = State(wrappedValue: instrument.sidesmaterial ?? "")
        _backMaterial      = State(wrappedValue: instrument.backmaterial ?? "")
        _fretboardMaterial = State(wrappedValue: instrument.fretboardmaterial ?? "")
        _neckMaterial      = State(wrappedValue: instrument.neckmaterial ?? "")
        _neckShape         = State(wrappedValue: instrument.neckshape ?? "")
        
        _purchasedfrom     = State(wrappedValue: instrument.purchasedfrom ?? "")
        _purchaseDate      = State(wrappedValue: instrument.purchasedate ?? Date())
        _purchaseValue     = State(wrappedValue: instrument.purchasevalue)
        
        _sold              = State(wrappedValue: instrument.sold)
        _soldto            = State(wrappedValue: instrument.soldto ?? "")
        _salesDate         = State(wrappedValue: instrument.saledate ?? Date())
        _salesValue        = State(wrappedValue: instrument.salevalue)
        _salesreason       = State(wrappedValue: instrument.salereason ?? "")
        
        _comments          = State(wrappedValue: instrument.comments ?? "")

    }

    var body: some View {

        Form {

            Picker("Instrument Type", selection: $type.onChange(updateValues)) {
                ForEach(instrument.instrumentTypes, id: \.self) { type in
                    Text("\(type)")
                }
            }

            Section(header: Text("Basic Info")) {

                HStack(alignment: .lastTextBaseline) {
                    Text("Brand")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    TextField("Brand", text: $brand.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Model")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Model", text: $model.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Body Shape")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Picker("", selection: $category.onChange(updateValues)) {
                        
                        
                        switch type {
                        case "Electric":
                            ForEach(instrument.electricBodyTypes, id: \.self) { type in
                                Text("\(type)")
                            }
                        case "Ukelele":
                            ForEach(instrument.ukeleleTypes, id: \.self) { type in
                                Text("\(type)")
                            }
                        case "Bass":
                            ForEach(instrument.bassBodyTypes, id: \.self) { type in
                                Text("\(type)")
                            }
                        case "Dulcimer":
                            ForEach(instrument.dulcimerBodyTypes, id: \.self) { type in
                                Text("\(type)")
                            }
                        default:
                            ForEach(instrument.acosuticBodyTypes, id: \.self) { type in
                                Text("\(type)")
                            }

                        }
                        
                    }
                    .font(.callout)
                }

                HStack {
                    Text("Finish Style")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Finish Style", text: $finishStyle.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Made In")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Made In", text: $madeIn.onChange(updateValues))
                        .font(.callout)
                }

                HStack(alignment: .center) {
                    Text("Date Manufactured")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Spacer()

                    DatePicker("Select Date", selection: $dateMade, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(maxHeight: 400)
                        
                }

                HStack {
                    Text("Serial Number")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Serial Number", text: $serialNummber.onChange(updateValues))
                        .font(.callout)
                }

            }
            .textCase(.none)
            .font(.headline)

            Section(header: Text("Material/Electronics")) {

                HStack {
                    Text("Electronics")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Eletronics", text: $electronics.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Neck")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Neck Material", text: $neckMaterial.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Neck Shape")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Neck Shape", text: $neckShape.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Top")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Top Material", text: $topMaterial.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Back")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Back Material", text: $backMaterial.onChange(updateValues))
                        .font(.callout)
                }

                HStack {
                    Text("Sides")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Sides Material", text: $sidesMaterial.onChange(updateValues))
                        .font(.callout)

                }

                HStack {
                    Text("Fretboard")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Fretboard Material", text: $fretboardMaterial.onChange(updateValues))
                        .font(.callout)
                }

            }
            .textCase(.none)
            .font(.headline)

            Section(header: Text("Purchase Details")) {

                HStack {
                    
                    Text("Purchased From")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Purchased From", text: $purchasedfrom.onChange(updateValues))
                        .font(.callout)

                }
                
                HStack(alignment: .center) {
                    
                    Text("Purchase Date")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Spacer()

                    DatePicker("Purchase Date", selection: $purchaseDate, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(maxHeight: 400)

                }

                HStack {
                    Text("Purchase Value")
                        .font(.caption)
                        .foregroundColor(.gray)

                    NumberEntryField(value: self.$purchaseValue.onChange(updateValues))
                        .font(.callout)
                        .keyboardType(.decimalPad)

                }

            }
             
            Section(header: Text("Sales Details")) {
                
                HStack(alignment: .center) {
                    
                    Text("Sold")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Toggle("", isOn: $sold.onChange(updateValues))

                }
                
                HStack {
                    
                    Text("Sold To")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Sold To", text: $soldto.onChange(updateValues))
                        .font(.callout)

                }
                
                
                HStack(alignment: .center) {
                    Text("Sale Date")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Spacer()

                    DatePicker("Sale Date", selection: $salesDate.onChange(updateValues), in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(maxHeight: 400)

                }

                HStack {
                    Text("Sale Value")
                        .font(.caption)
                        .foregroundColor(.gray)

                    NumberEntryField(value: self.$salesValue.onChange(updateValues))
                        .font(.callout)
                        .keyboardType(.decimalPad)
                }
                
                HStack {
                    Text("Sale Reason")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Sale Reason", text: $salesreason.onChange(updateValues))
                        .font(.callout)
                }

            }
            .textCase(.none)
            .font(.headline)

            Section(header: Text("Images")) {

                VStack {

                    Button(action: {
                        self.showingImagePicker.toggle()
                        self.imagePickerSource = .library
                    }) {
                        HStack(spacing:10) {
                            Image(systemName: "photo")
                                .foregroundColor(.green)
                            Text("Add Image from Lirbary")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                    }

                }

                VStack {
                    InstrumentsImagesRow(thePhotos: instrument.allPhotos)
                        .frame(minHeight: 100)
                }

                VStack {

                    Button(action: {
                        self.showingImagePicker.toggle()
                        self.imagePickerSource = .camera
                    }) {
                        HStack(spacing:10) {
                            Image(systemName: "camera.circle")
                                .foregroundColor(.green)
                            Text("Take New Image")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                    }

                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(source: self.imagePickerSource, image: self.$inputImage)
                }

            }
            .textCase(.none)
            .font(.headline)

            Section(header: Text("Comments")) {

                TextEditor(text: $comments.onChange(updateValues))
                    .font(.callout)
                    .frame(minHeight: 100)
                    .multilineTextAlignment(.leading)

            }
            .textCase(.none)
            .font(.headline)
            
            Section {

                Button(action: {
                    isShowingDeleteMessage.toggle()
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "minus.circle")
                        Text("Delete Instrument")
                    }
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 45,
                       maxHeight: 45,
                       alignment: .center)
                .font(.headline)
                .foregroundColor(.red)
                .alert(isPresented: $isShowingDeleteMessage) {

                    Alert(
                        title: Text("Are you sure you want to delete this?"),
                        message: Text("By confirming this action, it will permanently delete the instrument and all associated data!"),
                        primaryButton: .destructive(Text("Yes, delete it!")) {

                            dataController.delete(instrument)
                            self.presentation.wrappedValue.dismiss()

                        },
                        secondaryButton: .cancel()
                    )

                }

            }

        }
        .navigationBarTitle("Edit Guitars", displayMode: .inline)
        .onDisappear(perform: dataController.save)

    }

    func updateValues() {

        // notify that the items will change
        // if photos.... photos.instruments?.objectWillChange.send()
        // that's becasuse CoreData will propagate down (or UP) the changes
        instrument.objectWillChange.send()

        instrument.type              = type
        instrument.brand             = brand
        instrument.model             = model
        instrument.madein            = madeIn
        instrument.finishstyle       = finishStyle
        instrument.category          = category
        instrument.electronics       = electronics
        instrument.topmaterial       = topMaterial
        instrument.sidesmaterial     = sidesMaterial
        instrument.backmaterial      = backMaterial
        instrument.fretboardmaterial = fretboardMaterial
        instrument.datemanufactured  = dateMade
        instrument.serialnumber      = serialNummber
        instrument.neckmaterial      = neckMaterial
        instrument.neckshape         = neckShape
        instrument.purchasedfrom     = purchasedfrom
        instrument.purchasedate      = purchaseDate
        instrument.purchasevalue     = purchaseValue
        instrument.sold              = sold
        instrument.soldto            = soldto
        instrument.saledate          = salesDate
        instrument.salevalue         = salesValue
        instrument.salereason        = salesreason
        instrument.comments          = comments
    }

    func loadImage() {

        guard let inputImage = inputImage else {
            return
        }

        if imagePickerSource == .camera {
            print("Camera selected")

            let imageSaver = ImageSaver()
            imageSaver.writeToPhotoAlbum(image: inputImage)

        }

        let fixingOrientation = inputImage.fixOrientation()
        image = Image(uiImage: fixingOrientation)

        let newImage = Photos(context: managedObjectContext)
        newImage.instruments = instrument
        newImage.comments = "Details about this particular photo."
        newImage.photo = fixingOrientation.pngData()

        dataController.save()

    }

}

struct InstrumentsEditView_Previews: PreviewProvider {

    static var dataController = DataController.preview

    static var previews: some View {
        InstrumentsEditView(instrument: Instruments.example)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
