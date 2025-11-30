import Foundation

/// Collects programs defined in /samplePrograms folder.
struct ProgramLoader {

    /// All available programs (pulled from individual files)
    static let allPrograms: [ProgramDefinition] = [
        programSimpleAddition,
        programDifferenceDemo,
        programCountToFive
    ]
}
