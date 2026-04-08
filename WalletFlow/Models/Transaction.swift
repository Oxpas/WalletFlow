import Foundation

struct Transaction: Identifiable {
    let id: UUID
    var amount: Double
    var type: TransactionType
    var category: Category
    var note: String
    var date: Date
    let createdAt: Date
    
    init(id: UUID = UUID(), amount: Double, type: TransactionType, category: Category, note: String = "", date: Date = Date(), createdAt: Date = Date()) {
        self.id = id
        self.amount = amount
        self.type = type
        self.category = category
        self.note = note
        self.date = date
        self.createdAt = createdAt
    }
}
