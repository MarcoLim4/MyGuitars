//
//  LifeSpanView.swift
//  MyGuitars
//
//  Created by Marco Lima on 2021-03-01.
//

import SwiftUI

struct LifeSpanView: View {
    
    @Binding var lifespan: Int16

    let images = [Image(systemName: "2.square")]
    var label = ""
    var maximumRating: Int16 = 6
    var offIamge: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor  = Color.yellow
    
    var body: some View {
        
        HStack {
            
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<Int(maximumRating), id: \.self) { number in
                image(for: Int16(number))
                    .foregroundColor(number > self.lifespan ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.lifespan = Int16(number)
                    }
            }
        }
        
    }
    
    
    func image(for number: Int16) -> Image {

        if number > lifespan {
            return offIamge ?? Image(systemName: "\(number * 2).square")
        } else {
            return Image(systemName: "\(number * 2).square")
        }
        
    }}

struct LifeSpanView_Previews: PreviewProvider {
    static var previews: some View {
        LifeSpanView(lifespan: .constant(4))
    }
}
