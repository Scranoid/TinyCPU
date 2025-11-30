import Foundation

/// Represents the CPU's memory (fixed small size).
final class MemoryModel {
    
    /// Each memory cell holds an Instruction.
    private(set) var cells: [Instruction] = []
    
    init(size: Int = 16) {
        // Initialize memory with HALTs (empty state)
        self.cells = Array(repeating: .halt, count: size)
    }
    
    /// Load a full program into memory (starting at index 0)[this basically is the beginning of the program]
    func load(program: [Instruction]) {
        for i in 0..<program.count {
            if i < cells.count {
                cells[i] = program[i]
            }
        }
    }
    
    /// Read instruction at an address
    func read(at address: Int) -> Instruction {
        guard address >= 0 && address < cells.count else {
            return .halt
        }
        return cells[address]
    }
    
    /// Write instruction into memory
    func write(_ instruction: Instruction, at address: Int) {
        guard address >= 0 && address < cells.count else { return }
        cells[address] = instruction
    }
}
