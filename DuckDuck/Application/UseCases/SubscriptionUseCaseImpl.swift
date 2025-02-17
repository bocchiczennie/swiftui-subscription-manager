import Foundation
import SwiftData

final class SubscriptionUseCaseImpl: SubscriptionUseCase {
    private let repository: SubscriptionRepository
    private let aggregator: SubscriptionAggregationService

    init(
        repository: SubscriptionRepository = SubscriptionRepositoryImpl(),
        aggregator: SubscriptionAggregationService = SubscriptionAggregationService()
    ) {
        self.repository = repository
        self.aggregator = aggregator
    }

    func fetchAllSubscriptions(_ context: ModelContext) throws -> [Subscription] {
        return try repository.fetchAll(context)
    }

    func fetchSubscriptionsByRenewDate(_ context: ModelContext, searchDate: Date) throws -> [Subscription] {
        let subscriptions = try repository.fetchAll(context)
        let targetDay = Calendar.current.startOfDay(for: searchDate)

        return subscriptions.filter { sub in
            let renewDay = Calendar.current.startOfDay(for: sub.renewalDate)
            return renewDay == targetDay
        }
    }

    func addSubscription(_ context: ModelContext, _ subscription: Subscription) throws {
        var mutableSubscription = subscription
        // 更新日が過去にある場合は次月になるように更新
        mutableSubscription.adjustRenewalDateIfOverdue()
        try repository.save(context, mutableSubscription)
    }

    func updateSubscription(_ context: ModelContext, _ subscription: Subscription) throws {
        var mutableSubscription = subscription
        // 更新日が過去にある場合は次月になるように更新
        mutableSubscription.adjustRenewalDateIfOverdue()
        try repository.save(context, mutableSubscription)
    }

    func deleteSubscription(_ context: ModelContext, _ subscription: Subscription) throws {
        try repository.delete(context, subscription)
    }

    func getSubscription(_ context: ModelContext, by id: UUID) throws -> Subscription? {
        let subscriptionList = try repository.fetchAll(context)
        return subscriptionList.first(where: { $0.id == id })
    }

    func updateAllRenewalDatesIfOverdue(_ context: ModelContext) throws {
        var subscriptions = try repository.fetchAll(context)
        let now = Calendar.current.startOfDay(for: Date())

        for i in subscriptions.indices {
            // 更新日が過去にある場合は次月になるように更新
            subscriptions[i].adjustRenewalDateIfOverdue(now: now)
            try repository.save(context, subscriptions[i])
        }
    }

    func calculateTotals(_ subscriptions: [Subscription]) -> (Decimal, Decimal, Decimal) {
        let (annual, monthly, daily) = aggregator.calculateTotals(subscriptions)
        return (annual, monthly, daily)
    }
}
