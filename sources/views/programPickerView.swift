import SwiftUI

struct ProgramPickerView: View {
    let programs: [ProgramDefinition]
    var onPick: (ProgramDefinition) -> Void

    @Environment(\.tilt) private var tilt
    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Choose Program")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(theme.isDarkMode ? .white : .black)
                .padding(.horizontal, 4)

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 14),
                GridItem(.flexible(), spacing: 14)
            ], spacing: 14) {

                ForEach(programs, id: \.name) { program in
                    Button {
                        onPick(program)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(program.name)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundColor(theme.isDarkMode ? .white : .black)

                            Text("\(program.instructions.count) steps")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(theme.isDarkMode
                                    ? .white.opacity(0.6)
                                    : .black.opacity(0.6))
                        }
                        .padding(14)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.25), lineWidth: 1)
                        )
                        .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
