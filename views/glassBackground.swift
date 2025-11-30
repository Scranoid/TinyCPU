import SwiftUI
import CoreMotion

struct GlassBackground: View {
    @EnvironmentObject private var theme: ThemeManager
    @Environment(\.tilt) private var tilt

    private let motionManager = CMMotionManager()
    private let scale: CGFloat = 20

    var body: some View {
        ZStack {

            // Theme adaptive gradient
            LinearGradient(
                colors: theme.isDarkMode
                    ? [Color.black.opacity(0.9), Color.gray.opacity(0.5)]
                    : [Color.backgroundStart.opacity(0.6), Color.backgroundEnd.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .blur(radius: 45)
            .offset(x: tilt.tiltX, y: tilt.tiltY)
            .animation(.easeOut(duration: 0.25), value: tilt.tiltX)

            // Universal glass overlay
            Color.clear.background(.ultraThinMaterial)
        }
        .onAppear { startTilt() }
    }

    private func startTilt() {
        guard motionManager.isDeviceMotionAvailable else { return }

        motionManager.deviceMotionUpdateInterval = 1 / 30
        motionManager.startDeviceMotionUpdates(to: .main) { data, _ in
            guard let d = data else { return }
            tilt.tiltX = CGFloat(d.attitude.roll) * scale
            tilt.tiltY = CGFloat(d.attitude.pitch) * scale
        }
    }
}
