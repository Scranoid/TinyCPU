import SwiftUI

struct StatsHudView: View {

    @ObservedObject var cpu: CPUModel
    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Stats")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .opacity(0.8)

            statRow(label: "Cycles", value: "\(cpu.cycleCount)")
            statRow(label: "ALU Ops", value: "\(cpu.aluCount)")
            statRow(label: "Jumps", value: "\(cpu.jumpCount)")

            HStack {
                Text("State")
                Spacer()
                Text(cpu.isHalted ? "■ Halted" : "● Running")
                    .foregroundColor(cpu.isHalted ? .red : .green)
            }
            .font(.system(size: 12, weight: .medium, design: .rounded))

        }
        .padding(12)
        .background(.ultraThinMaterial)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.accentBlue.opacity(0.25), lineWidth: 1)
        )
        .shadow(radius: 6)
    }

    @ViewBuilder
    private func statRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
        .font(.system(size: 12, weight: .regular, design: .rounded))
    }
}
