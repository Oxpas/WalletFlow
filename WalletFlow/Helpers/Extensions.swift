import SwiftUI

// MARK: - Color Hex Init
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Date Formatting
extension Date {
    func formatted(as format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
    var dayMonthYear: String {
        formatted(as: "d MMMM yyyy")
    }
    
    var dayMonth: String {
        formatted(as: "d MMMM")
    }
    
    var shortDate: String {
        formatted(as: "dd.MM.yy")
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
    
    var dayLabel: String {
        if isToday { return "Сегодня" }
        if isYesterday { return "Вчера" }
        return dayMonthYear
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

// MARK: - Double Currency Formatting
extension Double {
    func asCurrency(symbol: String = "₽") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = " "
        let formatted = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return "\(formatted) \(symbol)"
    }
    
    var signedCurrency: String {
        let sign = self >= 0 ? "+" : ""
        return "\(sign)\(asCurrency())"
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: 1
        )
    }
}

extension View {
    func gradientButtonStyle() -> some View {
        modifier(GradientButton())
    }
}
