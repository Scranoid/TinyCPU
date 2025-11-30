import Foundation
///This is for the third demo program
let programSimpleAddition = ProgramDefinition(
    name: "Simple Addition",
    instructions: [
        .loadA(5),
        .loadB(3),
        .add,
        .storeA(10),
        .halt
    ]
)
