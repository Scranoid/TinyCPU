import SwiftUI
import Combine

// MARK: - Run Speed

enum RunSpeed: CaseIterable, Identifiable {
    case half, normal, double, quad

    var id: Self { self }

    var interval: TimeInterval {
        switch self {
        case .half:   return 1.2
        case .normal: return 0.6
        case .double: return 0.3
        case .quad:   return 0.15
        }
    }

    var label: String {
        switch self {
        case .half:   return "0.5×"
        case .normal: return "1×"
        case .double: return "2×"
        case .quad:   return "4×"
        }
    }
}

// MARK: - ContentView

struct ContentView: View {

    @StateObject private var cpu = CPUModel()
    @EnvironmentObject private var theme: ThemeManager
    @Environment(\.tilt) private var tilt

    // Auto-run state
    @State private var isRunning = false
    @State private var speed: RunSpeed = .normal
    @State private var timer: AnyCancellable?

    var body: some View {
        ZStack {

            // BACKGROUND
            GlassBackground()
                .ignoresSafeArea()

            // MAIN CONTENT
            VStack(spacing: 18)
                .animation(.easeInOut(duration: 0.25), value: cpu.cycleID)
            {

                // HEADER
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
                ProgramPickerView(programs: ProgramLoader.allPrograms) { program in
                    cpu.loadProgram(program.instructions)
                    stopAutoRun()
                }
                .padding(.horizontal)

                // REGISTERS
                HStack(spacing: 12) {
                    RegisterView(title: "A", value: String(cpu.registerA))
                    RegisterView(title: "B", value: String(cpu.registerB))
                    RegisterView(title: "PC", value: String(cpu.pc))

                    // IR with slide transition
                    RegisterView(title: "IR", value: cpu.ir.name)
                        .id(cpu.ir.name)
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            )
                        )
                }
                .padding(.horizontal)

                // MEMORY
                MemoryView(cells: cpu.memory.cells, currentPC: cpu.pc)
                    .frame(height: 80)
                    .padding(.horizontal)

                // ALU + RING
                ZStack {
                    aluRingView(active: cpu.aluActive)
                        .frame(width: 170, height: 170)

                    ALUView(
                        active: cpu.aluActive,
                        operationName: cpu.ir.name
                    )
                    .frame(width: 140, height: 140)
                }
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
                        cpu.executeNextCycle()
                        SoundManager.shared.play("cycle.wav")
                    },
                    onReset: {
                        cpu.reset()
                        stopAutoRun()
                        SoundManager.shared.play("register.wav")
                    },
                    onPlayPause: toggleAutoRun,
                    isRunning: $isRunning,
                    speed: $speed
                )
                .padding(.horizontal)
                .padding(.bottom, 16)

                Spacer(minLength: 6)
            }

            // STATS HUD (floating, top-right)
            VStack {
                HStack {
                    Spacer()
                    StatsHudView(cpu: cpu)
                        .padding(.trailing, 12)
                        .padding(.top, 12)
                }
                Spacer()
            }
        }
        // Auto-stop on HALT
        .onChange(of: cpu.isHalted) { halted in
            if halted { stopAutoRun() }
        }
    }

    // MARK: - Auto-Run Logic

    private func toggleAutoRun() {
        isRunning ? stopAutoRun() : startAutoRun()
    }

    private func startAutoRun() {
        guard !cpu.isHalted else { return }
        isRunning = true

        timer = Timer
            .publish(every: speed.interval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                cpu.executeNextCycle()
                SoundManager.shared.play("cycle.wav")
            }
    }

    private func stopAutoRun() {
        isRunning = false
        timer?.cancel()
        timer = nil
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ThemeManager())
    }
}
