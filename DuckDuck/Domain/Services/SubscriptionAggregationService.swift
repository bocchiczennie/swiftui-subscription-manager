import Foundation

struct SubscriptionAggregationService {
    func calculateTotals(_ subscriptions: [Subscription]) -> (Decimal, Decimal, Decimal) {
        subscriptions.reduce((Decimal.zero, .zero, .zero)) { partial, subscription in
            (
                partial.0 + subscription.annuallyPrice(),
                partial.1 + subscription.monthlyPrice(),
                partial.2 + subscription.dailyPrice()
            )
        }
    }

    func calculateAnnuallyTotalPrice(_ subscriptions: [Subscription]) -> Decimal {
        subscriptions.reduce(Decimal.zero) { partial, subscription in
            partial + subscription.annuallyPrice()
        }
    }
}
