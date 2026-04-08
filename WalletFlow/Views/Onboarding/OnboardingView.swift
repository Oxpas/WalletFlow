import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let color: Color
}

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0
    
    let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "creditcard.fill",
            title: "Учёт расходов",
            description: "Добавляйте доходы и расходы в пару касаний. Категоризируйте каждую транзакцию для полного контроля.",
            color: AppColors.primaryTeal
        ),
        OnboardingPage(
            icon: "chart.pie.fill",
            title: "Аналитика",
            description: "Наглядные графики покажут, куда уходят ваши деньги. Отслеживайте тренды по неделям и месяцам.",
            color: AppColors.primaryEmerald
        ),
        OnboardingPage(
            icon: "sparkles",
            title: "Начни сейчас",
            description: "Всё просто и бесплатно. Начните управлять своими финансами прямо сейчас!",
            color: Color(hex: "6366F1")
        )
    ]
    
    var body: some View {
        ZStack {
            Color(hex: "0F172A")
                .ignoresSafeArea()
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Custom page indicator
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Capsule()
                            .fill(index == currentPage ? pages[currentPage].color : Color.white.opacity(0.3))
                            .frame(width: index == currentPage ? 24 : 8, height: 8)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 20)
                
                // Button
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation(.spring()) {
                            currentPage += 1
                        }
                    } else {
                        withAnimation {
                            hasSeenOnboarding = true
                        }
                    }
                }) {
                    Text(currentPage < pages.count - 1 ? "Далее" : "Начать")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(AppColors.gradient)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                
                if currentPage < pages.count - 1 {
                    Button("Пропустить") {
                        withAnimation {
                            hasSeenOnboarding = true
                        }
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                }
                
                Spacer().frame(height: 20)
            }
        }
    }
}
