//
//  GradientButton.swift
//  WalletFlow
//
//  Created by Николай Замараев on 08.04.2026.
//

import SwiftUI

struct GradientButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(AppColors.gradient)
            .cornerRadius(14)
    }
}
