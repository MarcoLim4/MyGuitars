import SwiftUI
import SwiftData

struct ImagesShowImageView: View {

    let photo: Photos

    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentation
    @State private var isShowingDeleteMessage = false

    init(photo: Photos) {
        self.photo = photo
    }

    var body: some View {

        VStack {

            VStack(alignment: .trailing) {
                
                Button("Close") {
                    withAnimation {
                        presentation.wrappedValue.dismiss()
                    }
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 45,
                       maxHeight: 45,
                       alignment: .trailing)
                .padding(.trailing, 15)

            }

            let instPhoto = UIImage(data: photo.photo ?? Data()) ?? UIImage(named: "image05.png")

            Spacer()
            
            Image(uiImage: instPhoto ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 10)

            Spacer()

            Button("Delete Image") {
                isShowingDeleteMessage = true
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 45,
                   maxHeight: 45,
                   alignment: .center)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10.0)
            .shadow(radius: 5)
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .alert(isPresented: $isShowingDeleteMessage) {

                Alert(
                    title: Text("Delete Photo?"),
                    message: Text("Deleting the photo, removes the photo only from your guitar database!"),
                    primaryButton: .destructive(Text("Yes, delete it!")) {
                        context.delete(photo)
                        presentation.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )

            }

        }

    }

}

#if DEBUG
struct ImagesShowImageView_Previews: PreviewProvider {
    static let sampleInstrument: Instruments = {
        let instrument = Instruments()
        let somePhotos = SampleData().singlePhotoSample
        let samplePhoto = Photos()
        samplePhoto.photo = UIImage(named: "image05.png")?.pngData()
        instrument.photos = [somePhotos]
        return instrument
    }()

    static var previews: some View {
        ImagesShowImageView(photo: sampleInstrument.photos![0])
            .padding()
    }
}
#endif
