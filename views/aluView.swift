import SwiftUI
/// This is for the view pane of the ALU component in the tinyCPU simulator
/// same for all other view panes of the entire Views directory
struct ALUView: View {
    @Environment(\.tilt) private var tilt
    @EnvironmentObject private var theme: ThemeManager

    let active: Bool
    let operationName: String

    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Circle()
                        .stroke(
                            active ? Color.blue.opacity(0.7) :
                            theme.isDarkMode ? Color.white.opacity(0.25) :
                            Color.black.opacity(0.25),
                            lineWidth: active ? 3 : 1
                        )
                )
                .shadow(color: active
                        ? Color.blue.opacity(0.35)
                        : .clear,
                        radius: active ? 14 : 8)
                .scaleEffect(active ? 1.05 : 1.0)

            VStack(spacing: 4) {
                Text("ALU")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(theme.isDarkMode ? .white : .black)

                Text(operationName)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(theme.isDarkMode ? .white.opacity(0.8) : .black.opacity(0.8))
            }
        }
        .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
        .animation(.easeInOut(duration: 0.25), value: active)
    }
}
