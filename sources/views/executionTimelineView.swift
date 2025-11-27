import SwiftUI

struct ExecutionTimelineView: View {
    let cells: [Instruction]
    let currentPC: Int

    @Environment(\.tilt) private var tilt
    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {

                ForEach(Array(cells.enumerated()), id: \.0) { idx, instr in

                    let isActive = (idx == currentPC)
                    let isPast = (idx < currentPC)

                    Text(instr.name)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(.ultraThinMaterial)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(
                                    isActive ? Color.blue.opacity(0.7) :
                                    isPast ? Color.green.opacity(0.3) :
                                    Color.clear,
                                    lineWidth: isActive ? 2 : 1
                                )
                        )
                        .foregroundColor(theme.isDarkMode ? .white : .black)
                        .opacity(isPast ? 0.55 : 1.0)
                        .scaleEffect(isActive ? 1.08 : 1.0)
                        .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
                        .animation(.easeInOut(duration: 0.25), value: currentPC)
                }
            }
            .padding(.vertical, 8)
        }
    }
}
