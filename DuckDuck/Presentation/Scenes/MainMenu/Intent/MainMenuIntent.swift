/**
 Intent定義: ユーザーが検索画面で起こし得るアクションをenumで定義
 ユーザーの入力行為やボタン押下などの「やりたいこと」を定義する
 これにより、VIewは「ユーザーが何をしたいか」をViewModelに明示的に伝えることができる
 */

enum MainMenuIntent: Intent {
    case openSearch                 // 検索画面を開く
    case closeSearch                // 検索画面を閉じる
    case openRegistration           // 登録画面を開く
    case closeRegistration          // 登録画面を閉じる
    case openDetail(Subscription)   // 明細画面を開く
    case closeDetail                // 明細画面を閉じる
}
