import SwiftUI
import SwiftData

struct InstrumentsEditView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentation
    @StateObject private var viewModel: InstrumentsEditModel
    @State private var selectedInstrument: Instruments

    @State private var showingImagePicker = false
    @State private var imagePickerSource = PhotoSource.library
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var allPhotos: [Photos] = []
    @State private var isShowingDeleteMessage = false

    init(selectedInstrument: Instruments) {
        self.selectedInstrument = selectedInstrument
        _viewModel = StateObject(wrappedValue: InstrumentsEditModel(instrument: selectedInstrument))

    }

    var body: some View {

        Form {

            Picker("Instrument Type".localized, selection: $viewModel.type) {
                ForEach(selectedInstrument.instrumentTypes, id: \.self) { type in
                    Text("\(type)")
                }
            }

            Section("Basic Info".localized) {
                LabeledTextField(label: "Brand".localized, placeholder: "Brand".localized, text: $viewModel.brand)
                LabeledTextField(label: "Model".localized, placeholder: "Model".localized, text: $viewModel.model)

                HStack {

                    Text("Body Shape".localized)
                        .font(.caption)
                        .foregroundColor(.gray)

                    InstrumentPickerView(selection: $viewModel.category,
                                         type: viewModel.type,
                                         instrument: viewModel.instrument)

                }

                LabeledTextField(label: "Finish Style", placeholder: "Finish Style", text: $viewModel.finishStyle)
                LabeledTextField(label: "Made In".localized, placeholder: "Made In".localized, text: $viewModel.madeIn)
                DatePicker("Date Manufactured", selection: $viewModel.dateMade, displayedComponents: .date)
                    .font(.caption)
                    .foregroundColor(.gray)

                LabeledTextField(label: "Serial Number".localized, placeholder: "Serial Number".localized, text: $viewModel.serialNumber)

            }

            Section("Material/Electronics".localized) {
                LabeledTextField(label: "Electronics".localized, placeholder: "Electronics".localized, text: $viewModel.electronics)
                LabeledTextField(label: "Neck Material".localized, placeholder: "Neck Material".localized, text: $viewModel.neckMaterial)
                LabeledTextField(label: "Neck Shape".localized, placeholder: "Neck Shape".localized, text: $viewModel.neckShape)

                LabeledTextField(label: "Top".localized, placeholder: "Top".localized, text: $viewModel.topMaterial)
                LabeledTextField(label: "Back".localized, placeholder: "Back".localized, text: $viewModel.backMaterial)
                LabeledTextField(label: "Sides".localized, placeholder: "Sides".localized, text: $viewModel.sidesMaterial)
                LabeledTextField(label: "Fretboard".localized, placeholder: "Fretboard".localized, text: $viewModel.fretboardMaterial)

            }

            Section(header: Text("Purchase Details".localized)) {

                LabeledTextField(label: "Purchased From".localized, placeholder: "Purchased From".localized, text: $viewModel.purchasedFrom)
                DatePicker("Purchase Date", selection: $viewModel.purchaseDate, displayedComponents: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Text("Purchase Value")
                        .font(.caption)
                        .foregroundColor(.gray)

                    DollarAmountEditor(amount: $viewModel.purchaseValue)
                }
            }

            Section(header: Text("Sales Details".localized)) {

                Toggle("Sold".localized, isOn: $viewModel.sold)
                    .font(.caption)
                    .foregroundStyle(.gray)

                if viewModel.sold {
                    LabeledTextField(label: "Sold To".localized, placeholder: "Sold To".localized, text: $viewModel.soldTo)
                    DatePicker("Sale Date".localized, selection: $viewModel.salesDate, displayedComponents: .date)
                        .font(.caption)
                        .foregroundColor(.gray)

                    HStack {
                        Text("Sale Value")
                            .font(.caption)
                            .foregroundColor(.gray)

                        DollarAmountEditor(amount: $viewModel.salesValue)
                    }

                    LabeledTextField(label: "Sale Reason".localized, placeholder: "Sale Reason".localized, text: $viewModel.salesReason)
                }
            }

            Section(header: Text("Images".localized)) {

                VStack {
                    Button(action: {
                        showingImagePicker.toggle()
                        imagePickerSource = .library
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "photo")
                                .foregroundColor(.green)
                            Text("Add Image from Library")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.top)
                }

                VStack {
                    InstrumentsImagesRow(instrument: viewModel.instrument)
                        .frame(minHeight: 100)
                }

                VStack {

                    Button(action: {
                        showingImagePicker.toggle()
                        imagePickerSource = .camera
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
                .sheet(isPresented: $showingImagePicker, onDismiss: { refreshData(afterImageSelection: true) }) {
                    ImagePicker(source: imagePickerSource, image: $inputImage)
                }

            }

            Section(header: Text("Comments".localized)) {

                TextEditor(text: $viewModel.comments)
                    .font(.callout)
                    .frame(minHeight: 100)
                    .multilineTextAlignment(.leading)

            }
            .textCase(.none)
            .font(.headline)

            // Delete Button
            Section {

                Button(action: {
                    isShowingDeleteMessage.toggle()
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "trash")
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

                            context.delete(viewModel.instrument)
                            self.presentation.wrappedValue.dismiss()

                        },
                        secondaryButton: .cancel()
                    )

                }

            }

        }
        .navigationBarTitle("Edit Guitars".localized, displayMode: .inline)
        .onDisappear {
            refreshData()
        }

    }

    func refreshData(afterImageSelection: Bool = false) {
        if afterImageSelection {
            loadImage()
        }
        viewModel.saveChanges()
        allPhotos = viewModel.instrument.photos ?? []
        do {
            try context.save()
            print("Changes saved successfully!")
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
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

        let newImage = Photos()
        newImage.instruments = viewModel.instrument
        newImage.photo = fixingOrientation.pngData()
        newImage.comments = "Details about this particular photo."

        viewModel.saveChanges()

    }

}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        InstrumentEditViewContainer()
    }.modelContainer(previewContainer)
}

struct InstrumentEditViewContainer: View {

    @Query(sort: \Instruments.serialnumber) private var instrument: [Instruments]

    var body: some View {
        InstrumentsEditView(selectedInstrument: instrument[0])
    }
}


struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String

    @FocusState private var isFocused: Bool  // Focus state for TextField

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)

            ZStack(alignment: .trailing) {
                TextField(placeholder, text: $text)
                    .font(.callout)
                    .padding(.trailing, 30)
                    .focused($isFocused)  // Attach focus state

                if !text.isEmpty {
                    Button(action: {
                        text = ""
                        isFocused = true  // Refocus the TextField
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                }
            }
        }
    }
}


struct InstrumentPickerView: View {
    @Binding var selection: String
    let type: String
    let instrument: Instruments

    var body: some View {
        Picker("", selection: $selection) {
            ForEach(bodyTypes(for: type), id: \.self) { type in
                Text(type)
                    .font(.callout)
            }
        }
    }

    private func bodyTypes(for type: String) -> [String] {
        switch type {
        case "Acoustic".localized:
            return instrument.acosuticBodyTypes
        case "Electric".localized:
            return instrument.electricBodyTypes
        case "Bass".localized:
            return instrument.bassBodyTypes
        case "Dulcimer".localized:
            return instrument.dulcimerBodyTypes
        case "Ukeleles".localized:
            return instrument.ukeleleTypes
        default:
            return instrument.otherBodyTypes
        }
    }
}
