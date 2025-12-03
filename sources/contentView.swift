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
                // TITLE + THEME TOGGLE
                HStack {
                    Text("tiny cpu")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))

                    Spacer()

                    Button {
                        theme.toggle()
                    } label: {
                        Image(systemName: theme.isDarkMode ? "sun.max.fill" : "moon.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .dynamicShadow(tiltX: tilt.tiltX, tiltY: tilt.tiltY)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // PROGRAM PICKER
                ProgramPickerView(
                    programs: ProgramLoader.allPrograms
                ) { selected in
                    cpu.loadProgram(selected.instructions)
                }
                .padding(.horizontal)

                // REGISTERS
                HStack(spacing: 12) {
                    RegisterView(title: "A", value: String(cpu.registerA))
                    RegisterView(title: "B", value: String(cpu.registerB))
                    RegisterView(title: "PC", value: String(cpu.pc))
                    // IR with slide transition: id keyed to instruction name
                    RegisterView(title: "IR", value: cpu.ir.name)
                        .id(cpu.ir.name)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        ))
                }
                .padding(.horizontal)

                // MEMORY VIEW
                MemoryView(cells: cpu.memory.cells, currentPC: cpu.pc)
                    .frame(height: 80)
                    .padding(.horizontal)

                // ALU with circular ring
                ZStack {
                    aluRingView(active: cpu.aluActive)
                        .frame(width: 170, height: 170)

                    ALUView(active: cpu.aluActive, operationName: cpu.ir.name)
                        .frame(width: 140, height: 140)
                }
                .padding(.vertical, 4)

                // EXECUTION TIMELINE
                ExecutionTimelineView(cells: cpu.memory.cells, currentPC: cpu.pc)
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
                .padding(.bottom, 18)
                .padding(.horizontal)

                Spacer(minLength: 6)
            }
            .padding(.vertical, 8)
            .environmentObject(theme)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ThemeManager())
    }
}
