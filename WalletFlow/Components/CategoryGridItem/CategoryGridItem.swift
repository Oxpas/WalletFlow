//
//  CategoryGridItem.swift
//  WalletFlow
//
//  Created by Николай Замараев on 08.04.2026.
//

import SwiftUI

struct CategoryGridItem: View {
    let category: Category
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? category.color.opacity(0.15) : Color(hex: "F1F5F9"))
                    .frame(width: 56, height: 56)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? category.color : .clear, lineWidth: 2)
                    )
                
                Image(systemName: category.icon)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? category.color : AppColors.textSecondary)
            }
            
            Text(category.title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(isSelected ? category.color : AppColors.textSecondary)
                .lineLimit(1)
        }
    }
}
