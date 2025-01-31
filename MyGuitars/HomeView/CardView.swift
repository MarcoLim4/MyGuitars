import SwiftUI

struct CardViewData {
    let image: String
    let title: String
    let subTitle: String
    let summary: String
}

struct CardView: View {

    let cardView: CardViewData

    var body: some View {

        VStack(alignment: .leading) {

            VStack(alignment: .leading) {

                Text(cardView.title)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)

                Text(cardView.subTitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(10)

            }
            .padding(.leading, 20)

            VStack {

                Image(cardView.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                HStack {

                    VStack(alignment: .leading) {

                        Text(cardView.summary)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .lineLimit(10)

                    }
                    .layoutPriority(100)

                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            )
            .padding([.top, .horizontal])

        }

    }
}
struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
    let cardData = CardViewData(image: "guitars-panel",
                                title: "Guitar Summary",
                                subTitle: "Take a look at your guitar colletion!",
                                summary: "You have a lot of guiars and they are worth $000.")

        CardView(cardView: cardData)

    }
}
