import SwiftUI

struct ControlPanelView: View {
    var onNext: () -> Void
    var onReset: () -> Void
    var onPlayPause: () -> Void

    @Binding var isRunning: Bool
    @Binding var speed: RunSpeed

    @Environment(\.tilt) private var tilt

    var body: some View {
        VStack(spacing: 12) {

            // PLAY / PAUSE + STEP
            HStack(spacing: 16) {

                Button(action: onPlayPause) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 44, height: 36)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.accentBlue)

                Button(action: onNext) {
                    Text("Next")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .frame(width: 64, height: 36)
                }
                .buttonStyle(.bordered)

                Button(action: onReset) {
                    Text("Reset")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .frame(width: 64, height: 36)
                }
                .buttonStyle(.bordered)
            }

            // SPEED CONTROL
            Picker("Speed", selection: $speed) {
                ForEach(RunSpeed.allCases) { speed in
                    Text(speed.label).tag(speed)
                }
            }
            .pickerStyle(.segmented)
        }
        .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
    }
}
