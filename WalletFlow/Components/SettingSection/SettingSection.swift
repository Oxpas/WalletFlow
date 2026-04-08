//
//  SettingSection.swift
//  WalletFlow
//
//  Created by Николай Замараев on 08.04.2026.
//

import SwiftUI

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                content
                    .padding()
            }
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
