import SwiftUI

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var vm: TransactionViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.backgroundLight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // MARK: - Appearance
                        SettingsSection(title: "Внешний вид") {
                            Toggle(isOn: $isDarkMode) {
                                Label("Тёмная тема", systemImage: "moon.fill")
                            }
                            .tint(AppColors.primaryTeal)
                        }
                        
                        // MARK: - Data
                        SettingsSection(title: "Данные") {
                            Button {
                                showDeleteAlert = true
                            } label: {
                                HStack {
                                    Label("Удалить все данные", systemImage: "trash.fill")
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                        
                        // MARK: - About
                        SettingsSection(title: "О приложении") {
                            
                            HStack {
                                Label("Версия", systemImage: "info.circle.fill")
                                Spacer()
                                Text("1.0.0")
                                    .foregroundColor(AppColors.textSecondary)
                            }
                            
                            Divider()
                            
                            HStack {
                                Label("Разработчик", systemImage: "person.fill")
                                Spacer()
                                Text("WalletFlow Team")
                                    .foregroundColor(AppColors.textSecondary)
                            }
                            
                            Divider()
                            
                            Link(destination: URL(string: "https://example.com")!) {
                                Label("Политика конфиденциальности", systemImage: "lock.shield.fill")
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Настройки")
            .alert("Удалить все данные?", isPresented: $showDeleteAlert) {
                Button("Отмена", role: .cancel) {}
                Button("Удалить", role: .destructive) {
                    vm.deleteAllTransactions()
                }
            } message: {
                Text("Это действие нельзя отменить. Все транзакции будут удалены.")
            }
        }
        .navigationViewStyle(.stack)
    }
}
