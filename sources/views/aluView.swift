import SwiftUI

struct ALUView: View {
    @Environment(\.tilt) private var tilt
    @EnvironmentObject private var theme: ThemeManager

    let active: Bool
    let operationName: String

    var body: some View {
        ZStack {
            // Base liquid glass circle
            Circle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Circle()
                        .stroke(
                            active ? Color.accentBlue.opacity(0.9) :
                                (theme.isDarkMode ? Color.white.opacity(0.22) : Color.black.opacity(0.16)),
                            lineWidth: active ? 3.0 : 1.0
                        )
                )
                .shadow(color: active ? Color.accentBlue.opacity(0.35) : .clear, radius: active ? 14 : 8)
                .scaleEffect(active ? 1.05 : 1.0)

            VStack(spacing: 4) {
                Text("ALU")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(theme.isDarkMode ? .white : .black)

                Text(operationName)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(theme.isDarkMode ? .white.opacity(0.85) : .black.opacity(0.85))
                    .opacity(0.9)
            }
        }
        .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
        .animation(.easeInOut(duration: 0.22), value: active)
    }
}
