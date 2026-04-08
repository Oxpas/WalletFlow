//
//  OnboardingPageView.swift
//  WalletFlow
//
//  Created by Николай Замараев on 08.04.2026.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [page.color.opacity(0.3), .clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 120
                        )
                    )
                    .frame(width: 260, height: 260)
                    .scaleEffect(animate ? 1.1 : 0.9)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(page.color.opacity(0.15))
                        .frame(width: 140, height: 140)
                    
                    Image(systemName: page.icon)
                        .font(.system(size: 60, weight: .medium))
                        .foregroundColor(page.color)
                }
                .scaleEffect(animate ? 1.0 : 0.8)
            }
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(page.description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .lineSpacing(4)
            }
            
            Spacer()
            Spacer()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}

