import SwiftUI

extension Color {

    // MARK: - Light/Dark Adaptive Semantic Colors

    /// Primary foreground text color (auto-adapts to dark/light mode)
    static var primaryText: Color {
        Color("primaryText", bundle: .main)
    }

    /// Secondary text (dimmed)
    static var secondaryText: Color {
        Color("secondaryText", bundle: .main)
    }

    /// Accent blue (used for strokes, highlight glows, ALU border)
    static var accentBlue: Color {
        Color("accentBlue", bundle: .main)
    }

    // MARK: - Background Gradient Colors (used in glassBackground)

    /// Soft top-left gradient color (light mode)
    static let backgroundStart = Color(red: 0.92, green: 0.95, blue: 1.0)

    /// Soft bottom-right gradient color (light mode)
    static let backgroundEnd = Color(red: 0.80, green: 0.85, blue: 0.98)

    // Dark mode equivalents (used by glassBackground.swift)
    static let backgroundDarkStart = Color(red: 0.10, green: 0.10, blue: 0.12)
    static let backgroundDarkEnd   = Color(red: 0.16, green: 0.16, blue: 0.18)
}
