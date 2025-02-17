import Foundation

enum RegistrationIntent: Intent {
    case updateServiceName(String)                      // ユーザー名入力の更新
    case updateAmount(String)                           // 料金の更新
    case updateCategory(Category)                       // カテゴリーの更新
    case updateInterval(Cycle)                          // 契約更新間隔の更新
    case updateStartDate(Date)                          // 契約更新日の更新
    case updateMemo(String)                             // メモの更新
    case dismiss(() -> Void)                            // バツボタン押下
    case performRegister                                // 保存ボタン押下
    case performUpdate(Subscription)                    // 保存ボタン押下（サブスクリプションの更新）
}
