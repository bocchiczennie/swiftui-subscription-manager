import SwiftData
import Foundation

final class SubscriptionRepositoryImpl: SubscriptionRepository {

    func fetchAll(_ context: ModelContext) throws -> [Subscription] {
        // 全件取得
        let results = try context.fetch(FetchDescriptor<SubscriptionData>())
        // ドメインモデルに変換して返却
        return results.map { $0.toDomain() }
    }

    func save(_ context: ModelContext, _ subscription: Subscription) throws {
        // ドメイン → SwiftDataモデル に変換
        let dataModel = subscription.toData()
        // 重複チェック
        let uuidString = dataModel.id
        let descriptor = FetchDescriptor<SubscriptionData>(
            predicate: #Predicate { $0.id == uuidString }
        )
        if let existing = try context.fetch(descriptor).first {
            // すでに存在する場合はプロパティを更新
            existing.name = dataModel.name
            existing.amount = dataModel.amount
            existing.currency = dataModel.currency
            existing.cycleRawValue = dataModel.cycleRawValue
            existing.startDate = dataModel.startDate
            existing.renewalDate = dataModel.renewalDate
            existing.categoryRawValue = dataModel.categoryRawValue
            existing.memo = dataModel.memo
        } else {
            // 存在しなければ新規追加
            context.insert(dataModel)
        }

        try context.save()
    }

    func delete(_ context: ModelContext, _ subscription: Subscription) throws {
        let uuidString = subscription.id
        let descriptor = FetchDescriptor<SubscriptionData>(
            predicate: #Predicate { $0.id == uuidString }
        )
        guard let existing = try context.fetch(descriptor).first else {
            return
        }

        context.delete(existing)
        try context.save()
    }
}
