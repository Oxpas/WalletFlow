import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var vm: TransactionViewModel
    @State private var showAddTransaction = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.backgroundLight
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Balance Card
                        BalanceCardView(
                            balance: vm.balance,
                            income: vm.totalIncome,
                            expense: vm.totalExpense
                        )
                        .padding(.horizontal)
                        
                        // Recent Transactions
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Последние операции")
                                    .font(AppFonts.headline())
                                    .foregroundColor(AppColors.textPrimary)
                                
                                Spacer()
                                
                                if !vm.transactions.isEmpty {
                                    NavigationLink("Все") {
                                        HistoryView()
                                    }
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(AppColors.primaryTeal)
                                }
                            }
                            .padding(.horizontal)
                            
                            if vm.recentTransactions.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "tray")
                                        .font(.system(size: 40))
                                        .foregroundColor(AppColors.textSecondary.opacity(0.5))
                                    
                                    Text("Пока нет транзакций")
                                        .font(AppFonts.body())
                                        .foregroundColor(AppColors.textSecondary)
                                    
                                    Text("Нажмите + чтобы добавить первую")
                                        .font(AppFonts.caption())
                                        .foregroundColor(AppColors.textSecondary.opacity(0.7))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                            } else {
                                VStack(spacing: 0) {
                                    ForEach(vm.recentTransactions) { transaction in
                                        TransactionRowView(transaction: transaction)
                                        
                                        if transaction.id != vm.recentTransactions.last?.id {
                                            Divider()
                                                .padding(.leading, 60)
                                        }
                                    }
                                }
                                .padding(.leading, 10)
                                .padding(.trailing, -10)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                .background(AppColors.cardBackground)
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 100)
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                
                // FAB
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showAddTransaction = true }) {
                            ZStack {
                                Circle()
                                    .fill(AppColors.gradient)
                                    .frame(width: 60, height: 60)
                                    .shadow(color: AppColors.primaryTeal.opacity(0.4), radius: 12, y: 6)
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationTitle("WalletFlow")
            .sheet(isPresented: $showAddTransaction) {
                AddTransactionView()
            }
        }
        .navigationViewStyle(.stack)
    }
}

