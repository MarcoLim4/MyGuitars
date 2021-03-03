import SwiftUI
import CoreData

struct HomeView: View {

    @EnvironmentObject var dataController: DataController

    let instruments: FetchRequest<Instruments>
    let instrumentsSold: FetchRequest<Instruments>

    let strings: FetchRequest<Strings>
    let repairs: FetchRequest<Repairs>

    static let tag: String? = "Home"
    let layout = [GridItem(.flexible(minimum : 200))]
    
    let imagesPanel   = ["guitars-panel", "guitars-panel01", "guitars-panel02"]
    let imagesRepairs = ["guitars-repair", "guitars-repair01", "guitars-repair02"]
    let imagesStrings = ["string-change", "string-change01", "string-change02"]

    init() {

        let request: NSFetchRequest<Instruments> = Instruments.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Instruments.model, ascending: false)]
        request.predicate = NSPredicate(format: "sold = false")
        instruments = FetchRequest(fetchRequest: request)

        request.predicate = NSPredicate(format: "sold = true")
        instrumentsSold = FetchRequest(fetchRequest: request)

        let stringRequest: NSFetchRequest<Strings> = Strings.fetchRequest()
        stringRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Strings.date, ascending: false)]
        strings = FetchRequest(fetchRequest: stringRequest)

        let repairRequest: NSFetchRequest<Repairs> = Repairs.fetchRequest()
        repairRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Repairs.dateperformed, ascending: false)]
        repairs = FetchRequest(fetchRequest: repairRequest)

    }

    var body: some View {

        ScrollView {
            
//            VStack {
//                
//                Button(action: {
//                    
//                    dataController.deleteAll()
//                    dataController.save()
//                    
//                }, label: {
//                    Text("Button")
//                })
//                
//            }

            VStack {

                let guitarSummary = CardViewData(image: imagesPanel.randomElement() ?? "guitars-panel",
                                                 title: "Guitar Summary",
                                                 subTitle: "A look at your guitar collection",
                                                 summary: summaryGuitars)
                CardView(cardView: guitarSummary)

                let stringsSummary = CardViewData(image: imagesStrings.randomElement() ?? "string-change",
                                                  title: "All about strings",
                                                  subTitle: "See all the strings replaced so far!",
                                                  summary: summaryStrings)
                CardView(cardView: stringsSummary)

                let repairsSummary = CardViewData(image: imagesRepairs.randomElement() ?? "guitars-repair02",
                                                  title: "Your Repairs",
                                                  subTitle: "All the repairs!",
                                                  summary: summaryRepairs)

                CardView(cardView: repairsSummary)

            }

        }

    }

    var summaryGuitars: String {

        let totalCount = instruments.wrappedValue.count
        var stringResult = "You don't have any guitars added yet! Select the Guitars Tab and start adding new guitars!"
        if totalCount > 0 {

            let sum = instruments.wrappedValue.reduce(0) { $0 + ($1.value(forKey: "purchasevalue") as? Double ?? 0) }
            stringResult = "You have \(totalCount) guitars in your collection.\n"

            let totalWorth = sum.stringValue()
            stringResult += "Your \(totalCount == 1 ? "guitar" : "guitars") \(totalCount == 1 ? "is" : "are") worth \(totalWorth)\n"
        }

        let totalSold = instrumentsSold.wrappedValue.count
        if totalSold > 0 {

            let sumPurc = instrumentsSold.wrappedValue.reduce(0) { $0 + ($1.value(forKey: "purchasevalue") as? Double ?? 0) }
            let sumSold = instrumentsSold.wrappedValue.reduce(0) { $0 + ($1.value(forKey: "salevalue") as? Double ?? 0) }

            stringResult += "You have sold \(totalSold) \(totalCount == 1 ? "guitar" : "guitars")\n"
            stringResult += "You total purchase value is \(sumPurc.stringValue()).\n"
            stringResult += "You total sales value is \(sumSold.stringValue()).\n"

            if sumSold > sumPurc {
                stringResult += "So far.... Profit!!"
            } else if sumSold < sumPurc {
                stringResult += "So far.... no profit!!"
            }

        }

        return stringResult
    }

    var summaryStrings: String {

        let totalCount = strings.wrappedValue.count
        var stringResult = "So far, you not replaced any strings!"

        if totalCount > 0 {
            stringResult = "You have replaced \(totalCount) strings \(totalCount == 1 ? "set" : "sets") for your guitars.\n"
        }

        let sumCost = strings.wrappedValue.reduce(0) { $0 + ($1.value(forKey: "price") as? Double ?? 0) }
        if sumCost > 0 {
            stringResult += "You spent a total of \(sumCost.stringValue()) replacing strings.\n"
        }

        return stringResult
    }

    var summaryRepairs: String {

        let totalCount = repairs.wrappedValue.count
        var stringResult = "No repairs recorded yet!"

        if totalCount > 0 {
            stringResult = "So far, you have done \(totalCount) \(totalCount == 1 ? "repair" : "repairs") on your guitars.\n"
        }

        let sumCost = repairs.wrappedValue.reduce(0) { $0 + ($1.value(forKey: "cost") as? Double ?? 0) }
        if sumCost > 0 {
            stringResult += "The total cost is \(sumCost.stringValue())"
        }

        return stringResult
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
