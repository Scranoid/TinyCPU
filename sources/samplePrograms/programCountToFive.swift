import Foundation
/// This is the definition of a sample program that the user can simulate through the UI on tinyCPU
let programCountToFive = ProgramDefinition(
    name: "Count to Five Loop",
    instructions: [
        .loadA(0),   // A = 0
        .loadB(1),   // B = 1
        .add,        // A = A + 1
        .jump(2),    // Loop back to ADD
        .halt
    ]
)
 