import Foundation
import SwiftData

protocol SubscriptionUseCase {
    func fetchAllSubscriptions(_ context: ModelContext) throws -> [Subscription]
    func fetchSubscriptionsByRenewDate(_ context: ModelContext, searchDate: Date) throws -> [Subscription]
    func addSubscription(_ context: ModelContext, _ subscription: Subscription) throws
    func updateSubscription(_ context: ModelContext, _ subscription: Subscription) throws
    func deleteSubscription(_ context: ModelContext, _ subscription: Subscription) throws
    func getSubscription(_ context: ModelContext, by id: UUID) throws -> Subscription?
    func updateAllRenewalDatesIfOverdue(_ context: ModelContext) throws
    func calculateTotals(_ subscriptions: [Subscription]) -> (Decimal, Decimal, Decimal)
}
