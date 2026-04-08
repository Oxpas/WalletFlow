import SwiftUI

@main
struct WalletFlowApp: App {
    let coreDataManager = CoreDataManager.shared
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var showLaunch = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLaunch {
                    LaunchScreenView()
                        .transition(.opacity)
                } else if !hasSeenOnboarding {
                    OnboardingView()
                } else {
                    ContentView()
                        .environment(\.managedObjectContext, coreDataManager.context)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 0.6)) {
                        showLaunch = false
                    }
                }
            }
        }
    }
}
