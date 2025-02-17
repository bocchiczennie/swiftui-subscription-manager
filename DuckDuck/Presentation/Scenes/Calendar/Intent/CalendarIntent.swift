/**
 Intent定義: ユーザーが検索画面で起こし得るアクションをenumで定義
 ユーザーの入力行為やボタン押下などの「やりたいこと」を定義する
 これにより、VIewは「ユーザーが何をしたいか」をViewModelに明示的に伝えることができる
 */

import Foundation

enum CalendarIntent: Intent {
    case fetchSubscriptionsBySelectedDate   // 選択された日付からサブスクリプションを取得する
    case openModal                          // 小画面を開く
    case closeModal                         // 小画面を閉じる
}
