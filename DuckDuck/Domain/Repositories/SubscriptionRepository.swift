import SwiftData

protocol SubscriptionRepository {
    /// 全件取得
    func fetchAll(_ context: ModelContext) throws -> [Subscription]
    /// 追加・更新
    func save(_ context: ModelContext, _ subscription: Subscription) throws
    /// 削除
    func delete(_ context: ModelContext, _ subscription: Subscription) throws
}
