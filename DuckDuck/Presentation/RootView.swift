import SwiftUI

struct RootView: View {
    @Environment(\.modelContext) var modelContext
    @State var router: AppRouter = .init()
    private let subscriptionUseCase: SubscriptionUseCase

    init(subscriptionUseCase: SubscriptionUseCase = SubscriptionUseCaseImpl()) {
        self.subscriptionUseCase = subscriptionUseCase
    }

    var body: some View {
        NavigationStack {
            LayerContainer(router: router)
        }
        .onAppear {
            do {
                try subscriptionUseCase.updateAllRenewalDatesIfOverdue(modelContext)
            } catch {
                print("Failed to update overdue subscriptions: \(error)")
            }
        }
    }
}

#Preview {
    RootView()
}
