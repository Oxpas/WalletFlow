import SwiftUI

struct LaunchScreenView: View {
    @State private var logoScale: CGFloat = 0.3
    @State private var logoOpacity: Double = 0
    @State private var textOpacity: Double = 0
    @State private var rotation: Double = -30
    @State private var glowOpacity: Double = 0
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(hex: "0F172A"),
                    Color(hex: "1E293B")
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Glow effect
            Circle()
                .fill(
                    RadialGradient(
                        colors: [AppColors.primaryTeal.opacity(0.3), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .opacity(glowOpacity)
            
            VStack(spacing: 24) {
                // Logo icon
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(AppColors.gradient)
                        .frame(width: 120, height: 120)
                        .shadow(color: AppColors.primaryTeal.opacity(0.5), radius: 20, y: 10)
                    
                    Image(systemName: "wallet.pass.fill")
                        .font(.system(size: 50, weight: .medium))
                        .foregroundColor(.white)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                .rotationEffect(.degrees(rotation))
                
                // App name
                VStack(spacing: 8) {
                    Text("WalletFlow")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Управляй финансами легко")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
                .opacity(textOpacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                logoScale = 1.0
                logoOpacity = 1.0
                rotation = 0
            }
            
            withAnimation(.easeIn(duration: 0.6).delay(0.5)) {
                textOpacity = 1.0
            }
            
            withAnimation(.easeInOut(duration: 1.0).delay(0.3)) {
                glowOpacity = 1.0
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
