import SwiftUI

/// ボタンタップ時のハイライトエフェクトを無効にする
struct NoHighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.0 : 1.0) // タップ時の変化なし
            .opacity(configuration.isPressed ? 1.0 : 1.0)      // 不透明度変化なし
    }
}
