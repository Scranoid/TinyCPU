import SwiftUI

/// Lightweight theme manager used to toggle light/dark mode from the UI.
/// The `TinyCPUApp` injects an instance of this as an EnvironmentObject
/// and also uses preferredColorScheme(theme.isDarkMode ? .dark : .light).
final class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false

    init(defaultDark: Bool = false) {
        self.isDarkMode = defaultDark
    }

    func setDark(_ enabled: Bool) {
        withAnimation(.easeInOut(duration: 0.25)) {
            isDarkMode = enabled
        }
    }

    func toggle() {
        withAnimation(.easeInOut(duration: 0.25)) {
            isDarkMode.toggle()
        }
    }
}
