import SwiftUI

extension View {
    func dynamicShadow(tiltX: CGFloat, tiltY: CGFloat, radius: CGFloat = 12) -> some View {
        let offsetX = tiltX * 0.15
        let offsetY = tiltY * 0.15

        return self.shadow(
            color: Color.black.opacity(0.15),
            radius: radius,
            x: offsetX,
            y: offsetY
        )
    }
}
