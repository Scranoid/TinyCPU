import SwiftUI

struct RegisterView: View {
    let title: String
    let value: String

    @State private var animatePulse = false
    @Environment(\.tilt) private var tilt
    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(theme.isDarkMode ? .white.opacity(0.7) : .black.opacity(0.7))

            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.vertical, 10)
                .frame(minWidth: 70)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(theme.isDarkMode
                                ? Color.white.opacity(0.25)
                                : Color.black.opacity(0.15),
                                lineWidth: 0.5)
                )
                .scaleEffect(animatePulse ? 1.05 : 1.0)
                .animation(.easeOut(duration: 0.18), value: value)
                .onChange(of: value) { _ in
                    animatePulse = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                        animatePulse = false
                    }
                }
        }
        .padding(8)
        .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
    }
}
