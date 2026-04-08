import SwiftUI

struct AppColors {
    static let primaryTeal = Color(hex: "0D9488")
    static let primaryEmerald = Color(hex: "10B981")
    
    static let gradient = LinearGradient(
        colors: [primaryTeal, primaryEmerald],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Адаптивные цвета через UIColor
    static let background = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "0F172A")
            : UIColor(hex: "F8FAFC")
    })
    
    static let cardBackground = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "1E293B")
            : UIColor(hex: "FFFFFF")
    })
    
    static let textPrimary = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "F8FAFC")
            : UIColor(hex: "0F172A")
    })
    
    static let textSecondary = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "94A3B8")
            : UIColor(hex: "64748B")
    })
    
    static let incomeGreen = Color(hex: "10B981")
    static let expenseRed = Color(hex: "EF4444")
    
    // Оставляем для совместимости
    static let backgroundLight = background
    static let backgroundDark = Color(hex: "0F172A")
    static let cardBackgroundDark = Color(hex: "1E293B")
}

struct AppFonts {
    static func largeTitle() -> Font { .system(size: 34, weight: .bold, design: .rounded) }
    static func title() -> Font { .system(size: 22, weight: .bold, design: .rounded) }
    static func headline() -> Font { .system(size: 17, weight: .semibold, design: .rounded) }
    static func body() -> Font { .system(size: 17, weight: .regular, design: .default) }
    static func caption() -> Font { .system(size: 13, weight: .regular, design: .default) }
    static func amount() -> Font { .system(size: 28, weight: .bold, design: .monospaced) }
}
