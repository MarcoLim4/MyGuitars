import Foundation

class StringsEditModel: ObservableObject {

    var strings: Strings

    @Published var brand: String
    @Published var gauge: String
    @Published var date: Date
    @Published var lifespan: Int16
    @Published var myrating: Int16
    @Published var price: Double
    @Published var remembertochange: Bool
    @Published var comments: String

    init(strings: Strings) {
        self.strings = strings

        // Initialize fields from the instrument object
        self.brand = strings.brand ?? ""
        self.gauge = strings.gauge ?? ""
        self.date = strings.date ?? Date()
        self.lifespan = strings.lifespan ?? 0
        self.myrating = strings.myrating ?? 0
        self.price = strings.price ?? 0
        self.remembertochange = strings.remembertochange ?? false
        self.comments = strings.comments ?? ""

    }

    func saveChanges() {
        strings.brand = brand
        strings.gauge = gauge
        strings.date = date
        strings.lifespan = lifespan
        strings.myrating = myrating
        strings.price = price
        strings.remembertochange = remembertochange
        strings.comments = comments
    }

}
