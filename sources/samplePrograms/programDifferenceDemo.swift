import Foundation

let programDifferenceDemo = ProgramDefinition(
    name: "Difference Demo",
    instructions: [
        .loadA(8),
        .loadB(2),
        .sub,
        .halt
    ]
)
