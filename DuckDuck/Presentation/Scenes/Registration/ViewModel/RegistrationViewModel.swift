import Foundation
import SwiftData

@MainActor
final class RegistrationViewModel: ObservableObject, IntentHandler {
    typealias I = RegistrationIntent

    private var context: ModelContext?
    private let useCase: SubscriptionUseCase

    init(useCase: SubscriptionUseCase = SubscriptionUseCaseImpl()) {
        self.useCase = useCase
    }

    @Published var serviceName: String = ""
    @Published var amount: String = ""
    @Published var selectedSubscriptionCategory: Category = .undefined
    @Published var selectedInterval: Cycle = .monthly
    @Published var startDate: Date = Date()
    @Published var memo: String = ""
    @Published var isSaving: Bool = false

    var canClickSaveButton: Bool {
        !serviceName.isEmpty &&
        !amount.isEmpty &&
        !isSaving
    }

    var isSaveButtonDisabled: Bool {
        !canClickSaveButton
    }

    func setModelContext(_ context: ModelContext) {
        self.context = context
    }

    func setFormData(_ subscription: Subscription) {
        serviceName = subscription.name
        amount = NSDecimalNumber(decimal: subscription.price.amount).stringValue
        selectedSubscriptionCategory = subscription.category
        selectedInterval = subscription.cycle
        startDate = subscription.startDate
        memo = subscription.memo ?? ""
    }

    func send(intent: RegistrationIntent) {
        switch intent {
            case .updateServiceName(let newValue):
                serviceName = newValue
            case .updateAmount(let newValue):
                amount = newValue
            case .updateCategory(let newValue):
                selectedSubscriptionCategory = newValue
            case .updateInterval(let newValue):
                selectedInterval = newValue
            case .updateStartDate(let newValue):
                startDate = newValue
            case .updateMemo(let newValue):
                memo = newValue
            case .dismiss(let action):
                action()
            case .performRegister:
                isSaving = true
                do {
                    let amount = Decimal(string: amount) ?? 0
                    let currency = Locale.current.currency?.identifier ?? "JPY"
                    let price = Price(
                        amount: amount,
                        currency: currency
                    )

                    let subscription = Subscription(
                        id: UUID(),
                        name: serviceName,
                        price: price,
                        cycle: selectedInterval,
                        startDate: startDate,
                        renewalDate: startDate,
                        category: selectedSubscriptionCategory,
                        memo: memo
                    )
                    try useCase.addSubscription(context!, subscription)
                } catch {
                    print(error.localizedDescription)
                }
                isSaving = false
            case .performUpdate(let subscription):
                isSaving = true
                do {
                    let uuid = subscription.id
                    let amount = Decimal(string: amount) ?? 0
                    let currency = Locale.current.currency?.identifier ?? "JPY"
                    let price = Price(
                        amount: amount,
                        currency: currency
                    )

                    let subscription = Subscription(
                        id: uuid,
                        name: serviceName,
                        price: price,
                        cycle: selectedInterval,
                        startDate: startDate,
                        renewalDate: startDate,
                        category: selectedSubscriptionCategory,
                        memo: memo
                    )
                    try useCase.updateSubscription(context!, subscription)
                } catch {
                    print(error.localizedDescription)
                }
                isSaving = false

        }
    }
}
