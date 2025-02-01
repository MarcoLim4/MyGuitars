import Foundation

class RepairsEditModel: ObservableObject {

    var repairs: Repairs
    
    @Published var repairedby: String
    @Published var repairtype: String
    @Published var dateperformed: Date
    @Published var repairrate: Int16
    @Published var comments: String
    @Published var cost: Double

    init(repairs: Repairs) {
        self.repairs = repairs

        self.repairedby = repairs.repairedby ?? ""
        self.repairtype = repairs.repairtype ?? ""
        self.dateperformed = repairs.dateperformed ?? Date()
        self.repairrate = repairs.repairrate ?? 0
        self.comments = repairs.comments ?? ""
        self.cost = repairs.cost ?? 0
    }

    func saveChanges() {
        repairs.repairedby = repairedby
        repairs.repairtype = repairtype
        repairs.dateperformed = dateperformed
        repairs.repairrate = repairrate
        repairs.comments = comments
        repairs.cost = cost
    }

}



