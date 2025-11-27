import SwiftUI

struct MemoryView: View {
    let cells: [Instruction]
    let currentPC: Int

    @Environment(\.tilt) private var tilt
    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {

                ForEach(Array(cells.enumerated()), id: \.0) { idx, instr in

                    let isActive = (idx == currentPC)
                    let isPast = (idx < currentPC)

                    VStack(spacing: 6) {
                        Text(String(format: "%02d", idx))
                            .font(.caption)
                            .foregroundColor(theme.isDarkMode ? .white.opacity(0.7) : .black.opacity(0.7))

                        Text(instr.name)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .padding(8)
                            .frame(minWidth: 68)
                            .background(.regularMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        isActive ? Color.blue.opacity(0.6) :
                                        isPast ? Color.green.opacity(0.25) :
                                        Color.clear,
                                        lineWidth: isActive ? 1.5 : 1
                                    )
                            )
                            .opacity(isPast ? 0.55 : 1.0)
                            .shadow(color: isActive ? Color.blue.opacity(0.4) : .clear,
                                    radius: isActive ? 6 : 0)
                    }
                    .padding(4)
                    .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
                }
            }
            .padding(.vertical, 8)
        }
    }
}
