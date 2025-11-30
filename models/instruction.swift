import Foundation

/// Represents a simple TinyCPU instruction.(saare instructions yaha explicitly comments ke through define kiye hai)
enum Instruction: Equatable {
    case loadA(Int)     // LOAD A, value
    case loadB(Int)     // LOAD B, value
    case storeA(Int)    // STORE A, memoryIndex
    case add            // A = A + B
    case sub            // A = A - B
    case jump(Int)      // PC = address
    case halt           // Stops execution
    
    /// Human-readable name for UI display.(proper naming scheme for instructions so that ofc it doesnt confuse the users)
    var name: String {
        switch self {
        case .loadA: return "LOAD A"
        case .loadB: return "LOAD B"
        case .storeA: return "STORE A"
        case .add: return "ADD"
        case .sub: return "SUB"
        case .jump: return "JUMP"
        case .halt: return "HALT"
        }
    }
}
