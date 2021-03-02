import SwiftUI

struct HomeView: View {
    

    @EnvironmentObject var dataController: DataController

    static let tag: String? = "Home"
    let layout = [GridItem(.flexible(minimum : 200))]
    
    let items = ["Guitars", "Strings", "Work"]
    
    var body: some View {

        ScrollView {

            VStack {

                let cardData = CardViewData(image: "guitars-panel", title: "Guitar Summary", summary: "You have a lot of guiars and they are worth $000.")

                CardView(cardView: cardData)
                
            
            

                
                let cardData2 = CardViewData(image: "string-change", title: "Strings Summary", summary: "You have replaced yur guitars strings ## times. So far, your expenses with strings is $000.")

                
                CardView(cardView: cardData2)

            
            
            
                
                let repairs = CardViewData(image: "guitars-repair", title: "Your Repairs", summary: "So far, you have done 0 repairs on your guitars, with a total cost of $0.")

                
                CardView(cardView: repairs)

            }
            
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
