import Foundation

struct Subscription: Identifiable {
    private(set) var id: UUID
    private(set) var name: String
    private(set) var price: Price
    private(set) var cycle: Cycle
    private(set) var startDate: Date
    private(set) var renewalDate: Date
    private(set) var category: Category
    private(set) var memo: String?

    mutating func renew() {
        renewalDate = cycle.nextRenewalDate(from: renewalDate)
    }

    func dailyPrice() -> Decimal {
        switch cycle {
            case .weekly:
                return price.amount / 7
            case .monthly:
                return price.amount / 30
            case .annually:
                return price.amount / 365
            case .everyTwoYears:
                return price.amount / (365 * 2)
            case .everyThreeYears:
                return price.amount / (365 * 3)
        }
    }

    func monthlyPrice() -> Decimal {
        switch cycle {
                case .weekly:
                return price.amount / 7 * 30
            case .monthly:
                return price.amount
            case .annually:
                return price.amount / 12
            case .everyTwoYears:
                return price.amount / (12 * 2)
            case .everyThreeYears:
                return price.amount / (12 * 3)
        }
    }

    func annuallyPrice() -> Decimal {
        switch cycle {
            case .weekly:
                return price.amount / 7 * 365
            case .monthly:
                return price.amount * 12
            case .annually:
                return price.amount
            case .everyTwoYears:
                return price.amount / 2
            case .everyThreeYears:
                return price.amount / 3
        }
    }
}

extension Subscription {
    /// ドメインモデル → SwiftDataモデル への変換
    func toData() -> SubscriptionData {
        let cycleString = cycle.rawValue
        let categoryString = category.rawValue

        return SubscriptionData(
            id: self.id,
            name: self.name,
            amount: self.price.amount,
            currency: self.price.currency,
            cycleRawValue: cycleString,
            startDate: self.startDate,
            renewalDate: self.renewalDate,
            categoryRawValue: categoryString,
            memo: self.memo
        )
    }

    /// 現在日付を超えるまで renewalDate を更新
    mutating func adjustRenewalDateIfOverdue(now: Date = Date()) {
        let dayStart = Calendar.current.startOfDay(for: now)
        while renewalDate < dayStart {
            renew()
        }
    }
}
