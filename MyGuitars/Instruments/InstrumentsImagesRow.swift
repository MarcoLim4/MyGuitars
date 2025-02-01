import SwiftUI
import SwiftData


struct InstrumentsImagesRow: View {
    let layout = [GridItem(.flexible(minimum: 80))]

    @State private var showingImageView = false
    @State var instrument: Instruments
    @State private var selectedIndex: Int? = nil  // Start as nil

    var allPhotos: [Photos] {
        instrument.photos ?? []
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout, spacing: 20) {
                ForEach(Array(allPhotos.enumerated()), id: \.offset) { index, photoItem in
                    let instPhoto = photoItem.photo.flatMap { UIImage(data: $0) } ?? UIImage(named: "image05.png") ?? UIImage()

                    ZStack(alignment: .center) {
                        Image(uiImage: instPhoto)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .shadow(radius: 8)
                    }
                    .onTapGesture {
                        selectedIndex = index
                    }
                }
            }
            .padding(.horizontal)
        }
        .onChange(of: selectedIndex) { _, newIndex in
            if newIndex != nil {
                showingImageView = true  // Open sheet only after selection updates
            }
        }
        .sheet(isPresented: $showingImageView, onDismiss: {
            selectedIndex = nil  // Reset selection on dismiss
        }) {
            if let index = selectedIndex {
                ImagesShowImageView(photo: allPhotos[index])
            }
        }
    }
}

struct InstrumentsImagesRow_Previews: PreviewProvider {
    static let sampleInstrument: Instruments = {
        let instrument = Instruments()
        let somePhotos = SampleData().photosSample
        let samplePhoto = Photos()
        samplePhoto.photo = UIImage(named: "image05.png")?.pngData()
        instrument.photos = somePhotos
        return instrument
    }()

    static var previews: some View {
        InstrumentsImagesRow(instrument: sampleInstrument)
            .padding()
    }
}
