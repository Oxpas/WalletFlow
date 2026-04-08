import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            CategoryIconView(category: transaction.category, size: 44)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.category.title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(AppColors.textPrimary)
                
                Text(transaction.note.isEmpty ? transaction.date.shortDate : transaction.note)
                    .font(.system(size: 13))
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text("\(transaction.type == .income ? "+" : "-")\(transaction.amount.asCurrency())")
                .font(.system(size: 15, weight: .semibold, design: .monospaced))
                .foregroundColor(transaction.type == .income ? AppColors.incomeGreen : AppColors.expenseRed)
        }
        .padding(.vertical, 6)
    }
}
