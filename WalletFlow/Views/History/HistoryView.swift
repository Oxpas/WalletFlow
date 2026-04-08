import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var vm: TransactionViewModel
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.backgroundLight
                    .ignoresSafeArea()
                
                if vm.transactions.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "clock")
                            .font(.system(size: 50))
                            .foregroundColor(AppColors.textSecondary.opacity(0.4))
                        
                        Text("Нет операций")
                            .font(AppFonts.title())
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("Добавьте первую транзакцию\nна главном экране")
                            .font(AppFonts.body())
                            .foregroundColor(AppColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    List {
                        ForEach(vm.groupedByDay, id: \.0) { dayLabel, transactions in
                            Section(header:
                                        Text(dayLabel)

                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(AppColors.textSecondary)
                                .textCase(nil)
                                .cornerRadius(16)
                            ) {
                                ForEach(transactions) { transaction in
                                    TransactionRowView(transaction: transaction)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 4)
                                        .background(AppColors.cardBackground)
                                        .cornerRadius(16)
                                        .listRowBackground(Color.clear)
                                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                                        .listRowSeparator(.hidden)
                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                            Button(role: .destructive) {
                                                withAnimation {
                                                    vm.deleteTransaction(transaction)
                                                }
                                            } label: {
                                                Label("Удалить", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .searchable(text: $vm.searchText, prompt: "Поиск операций")
                }
            }
            .navigationTitle("История")
        }
        .navigationViewStyle(.stack)
    }
}
