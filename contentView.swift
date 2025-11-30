import SwiftUI

struct ContentView: View {

    @StateObject private var cpu = CPUModel()
    @EnvironmentObject private var theme: ThemeManager
    @Environment(\.tilt) private var tilt

    var body: some View {
        ZStack {
            GlassBackground()
                .ignoresSafeArea()

            VStack(spacing: 18)
                .animation(.easeInOut(duration: 0.25), value: cpu.cycleID)
            {
                // TITLE
                Text("tiny cpu")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .padding(.top, 12)

                // THEME TOGGLE BUTTON
                HStack {
                    Spacer()

                    Button {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            theme.isDarkMode.toggle()
                        }
                    } label: {
                        Image(systemName: theme.isDarkMode ? "sun.max.fill" : "moon.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
                    }
                }
                .padding(.horizontal)

                // PROGRAM PICKER GRID
                ProgramPickerView(
                    programs: ProgramLoader.allPrograms
                ) { selected in
                    cpu.memory.load(program: selected.instructions)
                    cpu.reset()
                }
                .padding(.bottom, 4)

                // REGISTERS ROW
                HStack(spacing: 12) {
                    RegisterView(title: "A", value: String(cpu.registerA))
                    RegisterView(title: "B", value: String(cpu.registerB))
                    RegisterView(title: "PC", value: String(cpu.pc))
                    RegisterView(title: "IR", value: cpu.ir.name)
                }
                .padding(.horizontal)

                // MEMORY VIEW
                MemoryView(
                    cells: cpu.memory.cells,
                    currentPC: cpu.pc
                )
                .frame(height: 80)
                .padding(.horizontal)

                // ALU
                ALUView(
                    active: cpu.aluActive,
                    operationName: cpu.ir.name
                )
                .frame(width: 140, height: 140)
                .padding(.vertical, 4)

                // EXECUTION TIMELINE
                ExecutionTimelineView(
                    cells: cpu.memory.cells,
                    currentPC: cpu.pc
                )
                .padding(.horizontal)

                // CONTROL PANEL
                ControlPanelView(
                    onNext: {
                        SoundManager.shared.play("cycle.wav")
                        cpu.executeNextCycle()
                    },
                    onReset: {
                        SoundManager.shared.play("register.wav")
                        cpu.reset()
                    }
                )
                .padding(.bottom, 20)

                Spacer()
            }
            .padding()
        }
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ThemeManager())
    }
}
