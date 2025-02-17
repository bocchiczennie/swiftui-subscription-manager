import Foundation

enum DetailIntent: Intent {
    case showAlert                      // アラートを表示する
    case hideAlert                      // アラートを非表示にする
    case openRegistration               // 登録画面を開く
    case closeRegistration              // 登録画面を閉じる
    case performDelete(Subscription)    // サブスクリプションの削除を実行する
}
