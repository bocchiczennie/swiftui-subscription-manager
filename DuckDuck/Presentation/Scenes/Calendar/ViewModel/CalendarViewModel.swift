import Foundation
import SwiftData

@MainActor
final class CalendarViewModel: ObservableObject, IntentHandler {
    typealias I = CalendarIntent

    private var context: ModelContext?
    private let useCase: SubscriptionUseCase

    init(useCase: SubscriptionUseCase = SubscriptionUseCaseImpl()) {
        self.useCase = useCase
    }

    @Published var nextRenewalSubscription : Subscription? = nil
    @Published var subscriptions: [Subscription]? = nil
    @Published var selectedDate: Date = Date()
    @Published var isModalPresented: Bool = false

    func setModelContext(_ context: ModelContext) {
        self.context = context
    }

    func onAppear() {
        do {
            var subscriptions = try useCase.fetchAllSubscriptions(context!)
            // 更新日の昇順で並び替え
            subscriptions.sort { $0.renewalDate < $1.renewalDate }
            // 次回更新されるサブスクリプションに設定
            nextRenewalSubscription = subscriptions.first
        } catch {
            print(error.localizedDescription)
        }
    }

    func send(intent: CalendarIntent) {
        switch intent {
            case .fetchSubscriptionsBySelectedDate:
                do {
                    subscriptions = try useCase.fetchSubscriptionsByRenewDate(context!, searchDate: selectedDate)
                } catch {
                    print(error.localizedDescription)
                }
            case .openModal:
                isModalPresented = true
            case .closeModal:
                isModalPresented = false
        }
    }
}
