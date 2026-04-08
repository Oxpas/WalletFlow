import SwiftUI

struct AddTransactionView: View {
    @EnvironmentObject var vm: TransactionViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var type: TransactionType = .expense
    @State private var amount = ""
    @State private var selectedCategory: Category = .food
    @State private var note = ""
    @State private var date = Date()
    
    private var categories: [Category] {
        type == .expense ? Category.expenseCategories : Category.incomeCategories
    }
    
    private var isValid: Bool {
        guard let value = Double(amount), value > 0 else { return false }
        return true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.backgroundLight
                    .ignoresSafeArea()
                
                // 🔽 Контент
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Type selector
                        Picker("Тип", selection: $type) {
                            ForEach(TransactionType.allCases, id: \.self) { t in
                                Text(t.title).tag(t)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        
                        // Amount
                        VStack(spacing: 8) {
                            Text("Сумма")
                                .font(AppFonts.caption())
                                .foregroundColor(AppColors.textSecondary)
                            
                            HStack {
                                TextField("0", text: $amount)
                                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(type == .income ? AppColors.incomeGreen : AppColors.expenseRed)
                                
                                Text("₽")
                                    .font(.system(size: 36, weight: .medium))
                                    .foregroundColor(AppColors.textSecondary)
                            }
                            .padding(.horizontal)
                        }
                        
                        // Category
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Категория")
                                .font(AppFonts.headline())
                                .foregroundColor(AppColors.textPrimary)
                                .padding(.horizontal)
                            
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4),
                                spacing: 12
                            ) {
                                ForEach(categories) { category in
                                    CategoryGridItem(
                                        category: category,
                                        isSelected: selectedCategory == category
                                    )
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3)) {
                                            selectedCategory = category
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Note
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Заметка")
                                .font(AppFonts.headline())
                                .foregroundColor(AppColors.textPrimary)
                            
                            TextField("Необязательно", text: $note)
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .foregroundColor(AppColors.textPrimary)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        // Date
                        HStack {
                            Text("Дата")
                                .font(AppFonts.headline())
                                .foregroundColor(AppColors.textPrimary)
                            
                            Spacer()
                            
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .labelsHidden()
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 100) // чтобы контент не прилипал к кнопке
                    }
                    .padding(.top, 8)
                }
                
                // 🔽 КНОПКА (фиксированная)
                VStack {
                    Spacer()
                    
                    Button(action: saveTransaction) {
                        Text("Сохранить")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                isValid
                                ? AppColors.gradient
                                : LinearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                    }
                    .disabled(!isValid)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Новая операция")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") { dismiss() }
                        .foregroundColor(AppColors.primaryTeal)
                }
            }
            .onChange(of: type) { _ in
                selectedCategory = categories.first ?? .other
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func saveTransaction() {
        guard let value = Double(amount), value > 0 else { return }
        vm.addTransaction(amount: value, type: type, category: selectedCategory, note: note, date: date)
        dismiss()
    }
}
