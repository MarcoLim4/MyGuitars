/*
 
 
 */

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int16
    
    var label = ""
    var maximumRating: Int16 = 5
    
    var offIamge: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor  = Color.yellow
    
    var body: some View {
        
        HStack {
            
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<Int(maximumRating) + 1) { number in
                self.image(for: Int16(number))
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = Int16(number)
                    }
            }
        }
        
    }
    
    
    func image(for number: Int16) -> Image {
        
        if number > rating {
            return offIamge ?? onImage
        } else {
            return onImage
        }
        
    }
    
    
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
