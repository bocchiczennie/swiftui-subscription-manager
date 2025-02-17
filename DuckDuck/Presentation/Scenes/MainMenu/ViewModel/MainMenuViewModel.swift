import Foundation
import SwiftData

@MainActor
final class MainMenuViewModel: ObservableObject, IntentHandler {
    typealias I = MainMenuIntent

    private var context: ModelContext?
    private let useCase: SubscriptionUseCase

    init(useCase: SubscriptionUseCase = SubscriptionUseCaseImpl()) {
        self.useCase = useCase
    }

    @Published var subscriptions: [Subscription] = []
    @Published var annuallyAmount: Decimal = 0
    @Published var monthlyAmount: Decimal = 0
    @Published var dailyAmount: Decimal = 0
    @Published var isRegistrationPresented: Bool = false
    @Published var isDetailPresented: Bool = false
    @Published var isFilterPresented: Bool = false
    @Published var selectedSubscription: Subscription? = nil

    func setModelContext(_ context: ModelContext) {
        self.context = context
    }

    func onAppear() {
        do {
            subscriptions = try useCase.fetchAllSubscriptions(context!)

            let (annuallyAmount, monthlyAmount, dailyAmount) = useCase.calculateTotals(subscriptions)

            self.annuallyAmount = annuallyAmount
            self.monthlyAmount = monthlyAmount
            self.dailyAmount = dailyAmount

        } catch {
            print(error.localizedDescription)
        }
    }

    func send(intent: MainMenuIntent) {
        switch intent {
            case .openSearch:
                isFilterPresented = true
            case .closeSearch:
                isFilterPresented = false
            case .openRegistration:
                isRegistrationPresented = true
            case .closeRegistration:
                isRegistrationPresented = false
            case .openDetail(let subscription):
                selectedSubscription = subscription
                isDetailPresented = true
            case .closeDetail:
                selectedSubscription = nil
                isDetailPresented = false
        }
    }
}
