import SwiftUI

struct ControlPanelView: View {
    var onNext: () -> Void
    var onReset: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button(action: onNext) {
                Text("Next Cycle")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            }
            .buttonStyle(.borderedProminent)

            Button(action: onReset) {
                Text("Reset")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            }
            .buttonStyle(.bordered)
        }
    }
}
