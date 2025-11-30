import SwiftUI
import CoreMotion

class TiltProvider: ObservableObject {
    @Published var tiltX: CGFloat = 0
    @Published var tiltY: CGFloat = 0
}

struct TiltEnvironmentKey: EnvironmentKey {
    static let defaultValue: TiltProvider = TiltProvider()
}

extension EnvironmentValues {
    var tilt: TiltProvider {
        get { self[TiltEnvironmentKey.self] }
        set { self[TiltEnvironmentKey.self] = newValue }
    }
}
