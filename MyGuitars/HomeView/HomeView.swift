import SwiftUI
import SwiftData

struct HomeView: View {

    @Environment(\.modelContext) private var context
    @Query private var myInstruments: [Instruments]
    @Query private var strings: [Strings]
    @Query private var repairs: [Repairs]

    static let tag: String? = "Home"
    let layout = [GridItem(.flexible(minimum : 200))]
    
    let imagesPanel   = ["guitars-panel", "guitars-panel01", "guitars-panel02"]
    let imagesRepairs = ["guitars-repair", "guitars-repair01", "guitars-repair02"]
    let imagesStrings = ["string-change", "string-change01", "string-change02"]

    init() {

    }

    var body: some View {

        ScrollView {

            VStack {

                let guitarSummary = CardViewData(image: imagesPanel.randomElement() ?? "guitars-panel",
                                                 title: "Guitar Summary".localized,
                                                 subTitle: "A look at your guitar collection".localized,
                                                 summary: summaryGuitars)
                CardView(cardView: guitarSummary)

                let stringsSummary = CardViewData(image: imagesStrings.randomElement() ?? "string-change",
                                                  title: "All about strings".localized,
                                                  subTitle: "See all the strings replaced so far!".localized,
                                                  summary: summaryStrings)
                CardView(cardView: stringsSummary)

                let repairsSummary = CardViewData(image: imagesRepairs.randomElement() ?? "guitars-repair02",
                                                  title: "Your Repairs".localized,
                                                  subTitle: "All the repairs!".localized,
                                                  summary: summaryRepairs)

                CardView(cardView: repairsSummary)

            }

        }

    }

    var summaryGuitars: String {

        let totalCount = myInstruments.count // instruments.wrappedValue.count
        var stringResult = "You don't have any guitars added yet! Select the Guitars Tab and start adding new guitars!".localized

        if totalCount > 0 {

            let sum = myInstruments.reduce(0) { $0 + ($1.purchasevalue ?? 0)}
            stringResult = String.localizedStringWithFormat( "You have %d guitars in your collection.\n".localized,
                                                             totalCount)

            let totalWorth = sum.stringValue()
            let instrumentCountStrings = totalCount == 1 ? "guitar".localized : "guitars".localized
            
            
            stringResult += String.localizedStringWithFormat("The estimatated amount of your %@ is %@.\n".localized,
                                                             instrumentCountStrings, totalWorth)
        }

        let totalSold = myInstruments.filter { $0.sold == true }.count
        if totalSold > 0 {
            let soldInstruments = myInstruments.filter { $0.sold == true }

            let sumPurc = soldInstruments.reduce(0) { $0 + ($1.purchasevalue ?? 0) }
            let sumSold = soldInstruments.reduce(0) { $0 + ($1.salevalue ?? 0) }

            stringResult += "You have sold \(totalSold) \(totalCount == 1 ? "guitar" : "guitars")\n"
            stringResult += "You total purchase value is \(sumPurc.stringValue()).\n"
            stringResult += "You total sales value is \(sumSold.stringValue()).\n"

            if sumSold > sumPurc {
                stringResult += "So far.... Profit!!".localized
            } else if sumSold < sumPurc {
                stringResult += "So far.... no profit!!".localized
            }

        }

        return stringResult
    }

    var summaryStrings: String {

        let totalCount = strings.count
        var stringResult = "So far, you have not replaced any strings!".localized

        if totalCount > 0 {
            let stringsSumm = "You have replaced %d string %@ for your guitars.\n".localized
            let stringTot = totalCount == 1 ? "set".localized : "sets".localized
            stringResult = String.localizedStringWithFormat(stringsSumm, totalCount, stringTot)
        }

        let sumCost = strings.reduce(0) { $0 + ($1.price ?? 0) }
        if sumCost > 0 {
            let localizedStringCost = "You spent a total of %@ replacing strings.\n".localized
            stringResult += String.localizedStringWithFormat(localizedStringCost, sumCost.stringValue())
        }

        return stringResult
    }

    var summaryRepairs: String {

        let totalCount = repairs.count
        var stringResult = "No repairs recorded yet!".localized

        if totalCount > 0 {
            let stringsCount = "So far, you have done %d %@ on your guitars.\n".localized
            let repair = totalCount == 1 ? "repair".localized : "repairs".localized
            stringResult = String.localizedStringWithFormat(stringsCount, totalCount, repair)
        }

        let sumCost = repairs.reduce(0) { $0 + ($1.cost ?? 0) }
        if sumCost > 0 {
            let localizedCost = "The total cost is %@".localized
            stringResult += String.localizedStringWithFormat(localizedCost, sumCost.stringValue())
        }

        return stringResult
    }

}

#if DEBUG
#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        HomeView()
    }.modelContainer(previewContainer)
}
#endif
