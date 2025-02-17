import Foundation
import SwiftData

@MainActor
final class DetailViewModel: ObservableObject, IntentHandler {
    typealias I = DetailIntent

    private var context: ModelContext?
    private let useCase: SubscriptionUseCase

    init(useCase: SubscriptionUseCase = SubscriptionUseCaseImpl()) {
        self.useCase = useCase
    }

    @Published var serviceName: String = ""
    @Published var cycle: Cycle = .monthly
    @Published var amount: Decimal = 0
    @Published var currency: String = Locale.current.currency?.identifier ?? "JPY"
    @Published var renewalDate: Date = Date()
    @Published var category: Category = .undefined
    @Published var memo: String = ""
    @Published var annuallyAmount: Decimal = 0
    @Published var monthlyAmount: Decimal = 0
    @Published var dailyAmount: Decimal = 0
    @Published var isRegistrationPresented: Bool = false
    @Published var showAlert: Bool = false

    func setModelContext(_ context: ModelContext) {
        self.context = context
    }

    func send(intent: DetailIntent) {
        switch intent {
            case .showAlert:
                showAlert = true
            case .hideAlert:
                showAlert = false
            case .openRegistration:
                isRegistrationPresented = true
            case .closeRegistration:
                isRegistrationPresented = false
            case .performDelete(let subscription):
                do {
                    try useCase.deleteSubscription(context!, subscription)
                } catch {
                    print(error.localizedDescription)
                }
                showAlert = false
        }
    }

    func setField(_ subscription: Subscription) {
        serviceName = subscription.name
        cycle = subscription.cycle
        amount = subscription.price.amount
        currency = subscription.price.currency
        renewalDate = subscription.renewalDate
        category = subscription.category
        memo = subscription.memo ?? ""
        annuallyAmount = subscription.annuallyPrice()
        monthlyAmount = subscription.monthlyPrice()
        dailyAmount = subscription.dailyPrice()
    }

    func reacquiringSubscription(_ subscription: Subscription) {
        do {
            let uuid = subscription.id
            if let reacquiredSubscription = try useCase.getSubscription(context!, by: uuid) {
                setField(reacquiredSubscription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
