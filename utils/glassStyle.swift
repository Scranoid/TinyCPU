import SwiftUI

/// Shared modifiers for Apple-style liquid glass UI.
extension View {

    /// A rounded glass card with subtle shadow.
    func glassCard(cornerRadius: CGFloat = 16) -> some View {
        self
            .background(.ultraThinMaterial)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
    }

    /// A stronger glass surface used for larger areas.
    func glassSurface(cornerRadius: CGFloat = 20) -> some View {
        self
            .background(.regularMaterial)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
    }
}
import SwiftUI

/// Shared modifiers for Apple-style liquid glass UI.
extension View {

    /// A rounded glass card with subtle shadow.
    func glassCard(cornerRadius: CGFloat = 16) -> some View {
        self
            .background(.ultraThinMaterial)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
    }

    /// A stronger glass surface used for larger areas.
    func glassSurface(cornerRadius: CGFloat = 20) -> some View {
        self
            .background(.regularMaterial)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
    }
}
