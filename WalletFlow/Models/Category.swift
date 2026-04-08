import SwiftUI

enum TransactionType: String, CaseIterable {
    case income = "income"
    case expense = "expense"
    
    var title: String {
        switch self {
        case .income: return "Доход"
        case .expense: return "Расход"
        }
    }
}

enum Category: String, CaseIterable, Identifiable {
    case food
    case transport
    case entertainment
    case shopping
    case health
    case education
    case salary
    case freelance
    case gift
    case bills
    case other
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .food: return "Еда"
        case .transport: return "Транспорт"
        case .entertainment: return "Развлечения"
        case .shopping: return "Покупки"
        case .health: return "Здоровье"
        case .education: return "Образование"
        case .salary: return "Зарплата"
        case .freelance: return "Фриланс"
        case .gift: return "Подарки"
        case .bills: return "Счета"
        case .other: return "Другое"
        }
    }
    
    var icon: String {
        switch self {
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .entertainment: return "gamecontroller.fill"
        case .shopping: return "bag.fill"
        case .health: return "heart.fill"
        case .education: return "book.fill"
        case .salary: return "banknote.fill"
        case .freelance: return "laptopcomputer"
        case .gift: return "gift.fill"
        case .bills: return "doc.text.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .food: return Color(hex: "F97316")
        case .transport: return Color(hex: "3B82F6")
        case .entertainment: return Color(hex: "A855F7")
        case .shopping: return Color(hex: "EC4899")
        case .health: return Color(hex: "EF4444")
        case .education: return Color(hex: "6366F1")
        case .salary: return Color(hex: "10B981")
        case .freelance: return Color(hex: "14B8A6")
        case .gift: return Color(hex: "F59E0B")
        case .bills: return Color(hex: "64748B")
        case .other: return Color(hex: "94A3B8")
        }
    }
    
    static var expenseCategories: [Category] {
        [.food, .transport, .entertainment, .shopping, .health, .education, .bills, .gift, .other]
    }
    
    static var incomeCategories: [Category] {
        [.salary, .freelance, .gift, .other]
    }
}
