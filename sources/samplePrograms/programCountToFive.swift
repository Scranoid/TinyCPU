import Foundation

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
