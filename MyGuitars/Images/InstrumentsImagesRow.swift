import SwiftUI

struct InstrumentsImagesRow: View {

    let layout = [GridItem(.flexible(minimum : 80))]
    @State private var showingImageView = false
    
    let thePhotos: [Photos]    
    
    var body: some View {
        
        ScrollView(.horizontal) {

            LazyHGrid(rows: layout, spacing: 20) {

                ForEach(thePhotos, id: \.self) { photoItem in

                    let instPhoto = UIImage(data: photoItem.photo ?? Data()) ?? UIImage(named: "image01.png")
                    
                    VStack(alignment: .center) {
                        
                        Image(uiImage: instPhoto ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50.0, height: 50.0, alignment: .center)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                            
                        NavigationLink(destination: ImagesShowImageView(photo: photoItem)) {
                            Label("", systemImage: "viewfinder")
                        }

                        
                        
//                        NavigationLink(destination: ImagesShowImageView(image: instPhoto ?? UIImage())) {
//                            Label("", systemImage: "viewfinder")
//                        }
 

                        // I want to make this a sheet view but can't :(
                        
                        //                        Button("View") {
                        //                            showingImageView.toggle()
                        //                        }
                        //                        .font(.footnote)
                        //                        .sheet(isPresented: $showingImageView, content: {
                        //                            ImagesShowImageView(image: instPhoto ?? UIImage())
                        //                        })


                    }
                    
                }

                

            }
            .padding(.horizontal)

        }
        
    }
    
}

struct InstrumentsImagesRow_Previews: PreviewProvider {
        
    static var previews: some View {
        InstrumentsImagesRow(thePhotos: Instruments.photosSample)
    }
}


//let myImages = [Image("image01.png"),
//                Image("image02.png"),
//                Image("image03.png"),
//                Image("image04.png"),
//                Image("image05.png"),
//                Image("image06.png"),
//                Image("image07.png")]
