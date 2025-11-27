import Foundation

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
