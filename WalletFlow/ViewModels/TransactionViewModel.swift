import SwiftUI
import CoreData
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var searchText = ""
    @Published var selectedPeriod: StatsPeriod = .month
    
    private let context = CoreDataManager.shared.context
    
    var totalIncome: Double {
        transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }
    
    var totalExpense: Double {
        transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }
    
    var balance: Double {
        totalIncome - totalExpense
    }
    
    var recentTransactions: [Transaction] {
        Array(transactions.prefix(5))
    }
    
    var filteredTransactions: [Transaction] {
        if searchText.isEmpty { return transactions }
        return transactions.filter {
            $0.category.title.localizedCaseInsensitiveContains(searchText) ||
            $0.note.localizedCaseInsensitiveContains(searchText) ||
            $0.amount.asCurrency().contains(searchText)
        }
    }
    
    var groupedByDay: [(String, [Transaction])] {
        let grouped = Dictionary(grouping: filteredTransactions) { $0.date.startOfDay }
        return grouped.sorted { $0.key > $1.key }.map { (key, value) in
            (key.dayLabel, value.sorted { $0.date > $1.date })
        }
    }
    
    var expensesByCategory: [(Category, Double)] {
        let periodTransactions = transactionsForPeriod(selectedPeriod)
        let expenses = periodTransactions.filter { $0.type == .expense }
        let grouped = Dictionary(grouping: expenses) { $0.category }
        return grouped.map { ($0.key, $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.1 > $1.1 }
    }
    
    var totalExpenseForPeriod: Double {
        expensesByCategory.reduce(0) { $0 + $1.1 }
    }
    
    init() {
        fetchTransactions()
    }
    
    func fetchTransactions() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "TransactionEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let results = try context.fetch(request)
            transactions = results.compactMap { entity in
                guard let id = entity.value(forKey: "id") as? UUID,
                      let amount = entity.value(forKey: "amount") as? Double,
                      let typeRaw = entity.value(forKey: "type") as? String,
                      let type = TransactionType(rawValue: typeRaw),
                      let categoryRaw = entity.value(forKey: "categoryRaw") as? String,
                      let category = Category(rawValue: categoryRaw),
                      let date = entity.value(forKey: "date") as? Date,
                      let createdAt = entity.value(forKey: "createdAt") as? Date
                else { return nil }
                
                let note = entity.value(forKey: "note") as? String ?? ""
                return Transaction(id: id, amount: amount, type: type, category: category, note: note, date: date, createdAt: createdAt)
            }
        } catch {
            print("Fetch error: \(error)")
        }
    }
    
    func addTransaction(amount: Double, type: TransactionType, category: Category, note: String, date: Date) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "TransactionEntity", into: context)
        entity.setValue(UUID(), forKey: "id")
        entity.setValue(amount, forKey: "amount")
        entity.setValue(type.rawValue, forKey: "type")
        entity.setValue(category.rawValue, forKey: "categoryRaw")
        entity.setValue(note, forKey: "note")
        entity.setValue(date, forKey: "date")
        entity.setValue(Date(), forKey: "createdAt")
        
        CoreDataManager.shared.save()
        fetchTransactions()
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "TransactionEntity")
        request.predicate = NSPredicate(format: "id == %@", transaction.id as CVarArg)
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            CoreDataManager.shared.save()
            fetchTransactions()
        } catch {
            print("Delete error: \(error)")
        }
    }
    
    func deleteAllTransactions() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TransactionEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            CoreDataManager.shared.save()
            transactions = []
        } catch {
            print("Delete all error: \(error)")
        }
    }
    
    private func transactionsForPeriod(_ period: StatsPeriod) -> [Transaction] {
        let calendar = Calendar.current
        let now = Date()
        let startDate: Date
        
        switch period {
        case .week:
            startDate = calendar.date(byAdding: .day, value: -7, to: now) ?? now
        case .month:
            startDate = calendar.date(byAdding: .month, value: -1, to: now) ?? now
        case .year:
            startDate = calendar.date(byAdding: .year, value: -1, to: now) ?? now
        }
        
        return transactions.filter { $0.date >= startDate }
    }
    
    var incomeByCategory: [(Category, Double)] {
        let periodTransactions = transactionsForPeriod(selectedPeriod)
        let incomes = periodTransactions.filter { $0.type == .income }
        let grouped = Dictionary(grouping: incomes) { $0.category }
        return grouped.map { ($0.key, $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.1 > $1.1 }
    }

    var totalIncomeForPeriod: Double {
        incomeByCategory.reduce(0) { $0 + $1.1 }
    }
}

enum StatsPeriod: String, CaseIterable {
    case week = "Неделя"
    case month = "Месяц"
    case year = "Год"
}
