import SwiftUI
import Foundation
import UIKit

struct InstrumentsEditView: View {
    
    let testImages = [UIImage(named: "image01.png") ?? UIImage(),
                      UIImage(named: "image02.png") ?? UIImage(),
                      UIImage(named: "image03.png") ?? UIImage(),
                      UIImage(named: "image04.png") ?? UIImage(),
                      UIImage(named: "image05.png") ?? UIImage(),
                      UIImage(named: "image06.png") ?? UIImage()]
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var imagePickerSource = PhotoSource.library
    @State private var inputImage: UIImage?
    
    
    let instrument: Instruments
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentation
    
    @State private var isShowingDeleteMessage = false
    
//MARK: - Data
    
    @State private var type: String
    @State private var brand: String
    @State private var model: String
    @State private var category: String
    @State private var madeIn: String
    @State private var finishStyle: String
    @State private var bodyShape: String

    @State private var dateMade: Date
    @State private var serialNummber: String
    
    @State private var eletronics: String
    @State private var topMaterial: String
    @State private var sidesMaterial: String
    @State private var backMaterial: String
    @State private var fretboardMaterial: String
    
    @State private var comments: String
    
    
    
    init(instrument: Instruments) {
        
        self.instrument = instrument
        
        _type              = State(wrappedValue: instrument.instType)
        _brand             = State(wrappedValue: instrument.instBrand)
        _model             = State(wrappedValue: instrument.instModel)
        _category          = State(wrappedValue: instrument.category ?? "")
        _madeIn            = State(wrappedValue: instrument.madein ?? "")
        _finishStyle       = State(wrappedValue: instrument.finishstyle ?? "")
        _bodyShape         = State(wrappedValue: instrument.bodyshape ?? "")
        _dateMade          = State(wrappedValue: instrument.datemanufactured ?? Date())
        _serialNummber     = State(wrappedValue: instrument.serialnumber ?? "")
        _eletronics        = State(wrappedValue: instrument.eletronics ?? "")
        _topMaterial       = State(wrappedValue: instrument.topmaterial ?? "")
        _sidesMaterial     = State(wrappedValue: instrument.sidesmaterial ?? "")
        _backMaterial      = State(wrappedValue: instrument.backmaterial ?? "")
        _fretboardMaterial = State(wrappedValue: instrument.fretboardmaterial ?? "")
        _comments          = State(wrappedValue: instrument.comments ?? "")
        
    }
    
    var body: some View {
        
        Form {
            
            Picker("Instrument Type", selection: $type) {
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
                    Text("Category")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Picker("", selection: $category) {
                        
                        // Maybe later we can swith on different body types for Bass and other instruments as well
                        if type == "Electric" {
                            ForEach(instrument.electricBodyTypes, id: \.self) { type in
                                Text("\(type)")
                            }
                        } else {
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
                
                
            }
            
            Section(header: Text("Images")) {
                
                VStack {
                    
                    Button(action: {
                        self.showingImagePicker = true
                        self.imagePickerSource = .library
                    }) {
                        HStack(spacing:10) {
                            Image(systemName: "viewfinder.circle")
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
                        self.showingImagePicker = true
                        self.imagePickerSource = .camera
                    }) {
                        HStack(spacing:10) {
                            Image(systemName: "camera.viewfinder")
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
            
            Section(header: Text("Other Info")) {
                
                HStack(alignment: .center) {
                    Text("Date Manufactured")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Spacer()
                    
                    DatePicker("Select Date", selection: $dateMade, displayedComponents: .date)
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

            
            Section(header: Text("Material")) {

                HStack {
                    Text("Eletronics")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Eletronics", text: $eletronics.onChange(updateValues))
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
            
            Section(header: Text("Comments")) {
                
                TextEditor(text: $comments.onChange(updateValues))
                    .font(.callout)
                    .frame(minHeight: 100)
                    .multilineTextAlignment(.leading)
                
            }

            
            Section {

                Button("Delete Instrument") {
                    isShowingDeleteMessage = true
                }
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
//        .onTapGesture { hideKeyboard() }
        .navigationTitle("Edit Guitars")
        .onDisappear(perform: dataController.save)

    }
    
    func updateValues() {
        
        // I'd like a better way to do this but maybe this is it...
        
        
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
        instrument.eletronics        = eletronics
        instrument.topmaterial       = topMaterial
        instrument.sidesmaterial     = sidesMaterial
        instrument.backmaterial      = backMaterial
        instrument.fretboardmaterial = fretboardMaterial
        instrument.datemanufactured  = dateMade
        instrument.serialnumber      = serialNummber
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
        
        image = Image(uiImage: inputImage)
        
        let newImage = Photos(context: managedObjectContext)
        newImage.instruments = instrument
        newImage.comments = "Details about this particular photo."
        newImage.photo = inputImage.pngData()
        
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

