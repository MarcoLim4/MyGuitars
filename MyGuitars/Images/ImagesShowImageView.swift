//
//  ImagesShowImageView.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-02-19.
//

import SwiftUI

struct ImagesShowImageView: View {
    
//    let image: String
    let image: UIImage
    
    var body: some View {
     
//        guard let another = another else { return }
        
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
        
//        Image(image)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
        
        
    }
}

struct ImagesShowImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesShowImageView(image: UIImage(named: "image05") ?? UIImage())
    }
}
