import SwiftUI

struct ImagesShowImageView: View {
    
    let photo: Photos
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentation
    
    @State private var imageComments: String
    @State private var isShowingDeleteMessage = false

    init(photo: Photos) {

        self.photo = photo
        _imageComments = State(wrappedValue: photo.comments ?? "")
    
    }

    
    var body: some View {
     
        
        VStack {
            
            Rectangle()
                .frame(width: 180, height: 5, alignment: .center)
                .foregroundColor(.gray)
                .cornerRadius(3.0)
                .padding(.top, 15)
                .shadow(radius: 10)


            let instPhoto = UIImage(data: photo.photo ?? Data()) ?? UIImage(named: "image02.png")
            
            Image(uiImage: instPhoto ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 10)
            
            Spacer()

//            TextEditor(text: $imageComments.onChange(updateValues))
//                .font(.callout)
//                .frame(minHeight: 50)
//                .multilineTextAlignment(.leading)
            
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
                        
                        dataController.delete(photo)
                        self.presentation.wrappedValue.dismiss()
                        
                    },
                    secondaryButton: .cancel()
                )
                    
            }
            
        }
        
    }
    
    func updateValues() {
        
    }
}

struct ImagesShowImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesShowImageView(photo: Instruments.photoSample)

    }
}
