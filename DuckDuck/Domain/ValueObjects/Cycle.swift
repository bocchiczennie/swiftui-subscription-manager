import Foundation

enum Cycle: String, CaseIterable, Identifiable, Codable {
    case weekly = "weekly"
    case monthly = "monthly"
    case annually = "annually"
    case everyTwoYears = "every_two_years"
    case everyThreeYears = "every_three_years"

    var id: Self { self }

    var localizedDescription: LocalizedDescription {
        let key = "cycle_\(self.rawValue)"
        return LocalizedDescription(key: key)
    }

    func nextRenewalDate(from current: Date) -> Date {
        let calendar = Calendar.current

        switch self {
            case .weekly:
                return calendar.date(byAdding: .day, value: 7, to: current) ?? current
            case .monthly:
                return calendar.date(byAdding: .month, value: 1, to: current) ?? current
            case .annually:
                return calendar.date(byAdding: .year, value: 1, to: current) ?? current
            case .everyTwoYears:
                return calendar.date(byAdding: .year, value: 2, to: current) ?? current
            case .everyThreeYears:
                return calendar.date(byAdding: .year, value: 3, to: current) ?? current
        }
    }
}
