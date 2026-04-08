import SwiftUI

struct BalanceCardView: View {
    let balance: Double
    let income: Double
    let expense: Double
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 6) {
                Text("Баланс")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
                
                Text(balance.asCurrency())
                    .font(AppFonts.amount())
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 0) {
                // Income
                VStack(spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 14))
                        Text("Доход")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(.white.opacity(0.7))
                    
                    Text(income.asCurrency())
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                
                Rectangle()
                    .fill(.white.opacity(0.2))
                    .frame(width: 1, height: 40)
                
                // Expense
                VStack(spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.down.circle.fill")
                            .font(.system(size: 14))
                        Text("Расход")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(.white.opacity(0.7))
                    
                    Text(expense.asCurrency())
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(AppColors.gradient)
                .shadow(color: AppColors.primaryTeal.opacity(0.4), radius: 16, y: 8)
        )
    }
}
