import SwiftUI

@main
struct TinyCPUApp: App {
    @StateObject private var theme = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
                .preferredColorScheme(theme.isDarkMode ? .dark : .light)
        }
    }
}
