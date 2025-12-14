import Foundation

/// The main CPU model for TinyCPU.
/// Publishes register values and small UI hints (aluActive, cycleID) for the SwiftUI layer.
final class CPUModel: ObservableObject {

    // MARK: - Registers & state (used for the main computation here)
    @Published var registerA: Int = 0
    @Published var registerB: Int = 0
    @Published var pc: Int = 0
    @Published var ir: Instruction = .halt

    @Published var isHalted: Bool = false

    /// True for a short moment when the ALU performs ADD/SUB
    /// (used to trigger ALU animation & sound)
    @Published var aluActive: Bool = false

    /// Unique value updated every cycle — convenient animation trigger for the UI
    @Published var cycleID: UUID = UUID()

    // MARK: - Stats (for Stats HUD)
    @Published var cycleCount: Int = 0
    @Published var aluCount: Int = 0
    @Published var jumpCount: Int = 0

    // MARK: - Memory
    let memory: MemoryModel

    // MARK: - Init
    init(memorySize: Int = 16) {
        self.memory = MemoryModel(size: memorySize)
    }

    // MARK: - Reset
    func reset() {
        DispatchQueue.main.async {
            self.registerA = 0
            self.registerB = 0
            self.pc = 0
            self.ir = .halt
            self.isHalted = false
            self.aluActive = false
            self.cycleID = UUID()

            // reset stats
            self.cycleCount = 0
            self.aluCount = 0
            self.jumpCount = 0
        }
    }

    // MARK: - Load program convenience
    func loadProgram(_ instructions: [Instruction]) {
        memory.load(program: instructions)
        reset()
    }

    // MARK: - One execution cycle (Fetch -> Decode -> Execute)
    func executeNextCycle() {
        guard !isHalted else { return }

        // FETCH
        let fetched = memory.read(at: pc)
        DispatchQueue.main.async {
            self.ir = fetched
            self.cycleCount += 1
        }

        // Decode & Execute (performed state changes on main queue to be UI-safe)
        switch fetched {

        case .loadA(let value):
            DispatchQueue.main.async {
                self.registerA = value
                self.pc += 1
                self.cycleID = UUID()
            }

        case .loadB(let value):
            DispatchQueue.main.async {
                self.registerB = value
                self.pc += 1
                self.cycleID = UUID()
            }

        case .storeA(let index):
            /*
             This does NOT break anything.
             We intentionally store the value of A as a LOAD instruction so:
             - memory remains instruction-based
             - MemoryView can still render instruction names
             - the simulator stays consistent
            */
            DispatchQueue.main.async {
                self.memory.write(.loadA(self.registerA), at: index)
                self.pc += 1
                self.cycleID = UUID()
                SoundManager.shared.play("register.wav")
            }

        case .add:
            DispatchQueue.main.async {
                SoundManager.shared.play("alu.wav")
                self.aluActive = true
                self.aluCount += 1
                self.registerA = self.registerA + self.registerB
                self.pc += 1
                self.cycleID = UUID()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.aluActive = false
            }

        case .sub:
            DispatchQueue.main.async {
                SoundManager.shared.play("alu.wav")
                self.aluActive = true
                self.aluCount += 1
                self.registerA = self.registerA - self.registerB
                self.pc += 1
                self.cycleID = UUID()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.aluActive = false
            }

        case .jump(let address):
            DispatchQueue.main.async {
                self.jumpCount += 1
                if address >= 0 && address < self.memory.cells.count {
                    self.pc = address
                } else {
                    // invalid jump -> treat as halt to avoid runaway
                    self.isHalted = true
                }
                self.cycleID = UUID()
            }

        case .halt:
            DispatchQueue.main.async {
                self.isHalted = true
                self.cycleID = UUID()
            }
        }
    }
}
