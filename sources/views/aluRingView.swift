import SwiftUI
// I've implented this for a circular timeline view which will help the users to see the circular timeline ring of the implemented program
struct aluRingView: View {
    let active: Bool
    @EnvironmentObject private var theme: ThemeManager

    @State private var rotation: Double = 0
    @State private var isSpinning: Bool = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.92)
            .stroke(
                AngularGradient(gradient: Gradient(colors: gradientColors), center: .center),
                style: StrokeStyle(lineWidth: active ? 6 : 4, lineCap: .round)
            )
            .rotationEffect(.degrees(rotation))
            .shadow(color: active ? Color.accentBlue.opacity(0.3) : .clear, radius: active ? 10 : 0)
            .onChange(of: active) { new in
                if new {
                    startSpin()
                } else {
                    stopSpin()
                }
            }
            .onAppear {
                if active { startSpin() }
            }
    }

    private var gradientColors: [Color] {
        if active {
            return [Color.accentBlue, Color.cyan, Color.accentBlue]
        } else {
            return [Color.gray.opacity(0.35), Color.gray.opacity(0.2)]
        }
    }

    private func startSpin() {
        guard !isSpinning else { return }
        isSpinning = true
        withAnimation(.linear(duration: 0.9).repeatForever(autoreverses: false)) {
            rotation = rotation + 360
        }
    }

    private func stopSpin() {
        isSpinning = false
        rotation = 0
    }
}
