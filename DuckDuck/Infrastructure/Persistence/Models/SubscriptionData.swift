import SwiftUI
import SwiftData

@Model
final class SubscriptionData {
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Decimal
    var currency: String
    var cycleRawValue: String
    var startDate: Date
    var renewalDate: Date
    var categoryRawValue: String
    var memo: String?

    init(
        id: UUID = UUID(),
        name: String,
        amount: Decimal,
        currency: String,
        cycleRawValue: String,
        startDate: Date,
        renewalDate: Date,
        categoryRawValue: String,
        memo: String? = nil
    ) {
        self.id = id
        self.name = name
        self.amount = amount
        self.currency = currency
        self.cycleRawValue = cycleRawValue
        self.startDate = startDate
        self.renewalDate = renewalDate
        self.categoryRawValue = categoryRawValue
        self.memo = memo
    }
}

extension SubscriptionData {
    /// SwiftDataモデル → ドメインモデル への変換
    func toDomain() -> Subscription {
        let cycleEnum = Cycle(rawValue: cycleRawValue) ?? .monthly
        let categoryEnum = Category(rawValue: categoryRawValue) ?? .undefined

        return Subscription(
            id: self.id,
            name: self.name,
            price: Price(amount: self.amount, currency: self.currency),
            cycle: cycleEnum,
            startDate: self.startDate,
            renewalDate: self.renewalDate,
            category: categoryEnum,
            memo: self.memo
        )
    }
}
