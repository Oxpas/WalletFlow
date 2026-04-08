import SwiftUI

struct ContentView: View {
    @StateObject private var transactionVM = TransactionViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
            
            HistoryView()
                .tabItem {
                    Label("История", systemImage: "clock.fill")
                }
            
            StatisticsView()
                .tabItem {
                    Label("Статистика", systemImage: "chart.pie.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gearshape.fill")
                }
        }
        .environmentObject(transactionVM)
        .accentColor(AppColors.primaryTeal)
    }
}
