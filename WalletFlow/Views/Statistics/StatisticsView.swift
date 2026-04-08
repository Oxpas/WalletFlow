import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var vm: TransactionViewModel
    @State private var showExpenses = true
    

    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Period picker
                        Picker("Период", selection: $vm.selectedPeriod) {
                            ForEach(StatsPeriod.allCases, id: \.self) { period in
                                Text(period.rawValue).tag(period)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        
                    
                        Picker("Тип", selection: $showExpenses) {
                            Text("Расходы").tag(true)
                            Text("Доходы").tag(false)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        
                        let data = showExpenses ? vm.expensesByCategory : vm.incomeByCategory
                        let total = showExpenses ? vm.totalExpenseForPeriod : vm.totalIncomeForPeriod
                        
                        if data.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "chart.pie")
                                    .font(.system(size: 50))
                                    .foregroundColor(AppColors.textSecondary.opacity(0.4))
                                
                                Text("Нет данных за этот период")
                                    .font(AppFonts.body())
                                    .foregroundColor(AppColors.textSecondary)
                            }
                            .padding(.top, 60)
                        } else {
                            PieChartView(data: data, total: total)
                                .frame(height: 240)
                                .padding(.horizontal)
                            
                            Text("\(showExpenses ? "Расходы" : "Доходы"): \(total.asCurrency())")
                                .font(AppFonts.headline())
                                .foregroundColor(AppColors.textPrimary)
                            
                            VStack(spacing: 0) {
                                ForEach(data, id: \.0) { category, amount in
                                    HStack(spacing: 12) {
                                        CategoryIconView(category: category, size: 40)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(category.title)
                                                .font(.system(size: 15, weight: .medium))
                                                .foregroundColor(AppColors.textPrimary)
                                            
                                            GeometryReader { geo in
                                                ZStack(alignment: .leading) {
                                                    RoundedRectangle(cornerRadius: 3)
                                                        .fill(AppColors.textSecondary.opacity(0.15))
                                                        .frame(height: 6)
                                                    
                                                    RoundedRectangle(cornerRadius: 3)
                                                        .fill(category.color)
                                                        .frame(width: geo.size.width * CGFloat(amount / total), height: 6)
                                                }
                                            }
                                            .frame(height: 6)
                                        }
                                        
                                        VStack(alignment: .trailing, spacing: 2) {
                                            Text(amount.asCurrency())
                                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                                .foregroundColor(AppColors.textPrimary)
                                            
                                            Text("\(Int(amount / total * 100))%")
                                                .font(.system(size: 12))
                                                .foregroundColor(AppColors.textSecondary)
                                        }
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 16)
                                    
                                    if category != data.last?.0 {
                                        Divider().padding(.leading, 68)
                                    }
                                }
                            }
                            .background(AppColors.cardBackground)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Статистика")
        }
        .navigationViewStyle(.stack)
    }
}
