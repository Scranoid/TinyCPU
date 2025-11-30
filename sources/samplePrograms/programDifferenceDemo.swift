import Foundation
///This is for the second demo program
let programDifferenceDemo = ProgramDefinition(
    name: "Difference Demo",
    instructions: [
        .loadA(8),
        .loadB(2),
        .sub,
        .halt
    ]
)
