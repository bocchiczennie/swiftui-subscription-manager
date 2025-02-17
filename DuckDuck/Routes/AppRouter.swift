import SwiftUI
import Foundation

@MainActor
final class AppRouter: ObservableObject, IntentHandler {
    typealias I = RootIntent
    @Published var path: Destination = .home

    /// Intentを受け取り、内部状態を更新・処理する
    /// - Parameters:
    ///   - intent: ユーザーが起こし得るアクション
    func send(intent: RootIntent) {
        switch intent {
            case .switchingPages(let destination):
                self.path = destination
        }
    }
}
