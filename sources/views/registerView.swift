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
                .foregroundColor(theme.isDarkMode ? .white.opacity(0.85) : .black.opacity(0.85))

            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.vertical, 10)
                .frame(minWidth: 70)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(theme.isDarkMode ? Color.white.opacity(0.18) : Color.black.opacity(0.12), lineWidth: 0.5)
                )
                // general small pulse on value change
                .scaleEffect(animatePulse ? 1.05 : 1.0)
                .animation(.easeOut(duration: 0.18), value: value)
                .onChange(of: value) { _ in
                    animatePulse = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                        animatePulse = false
                    }
                }
                // PC-specific stronger pulse & halo
                .overlay(
                    Group {
                        if title == "PC" && animatePulse {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.45), lineWidth: 2)
                                .blur(radius: 6)
                        }
                    }
                )

        }
        .padding(8)
        // apply dynamic shadow to the whole register card
        .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
    }
}
