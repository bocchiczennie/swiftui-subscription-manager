import SwiftUI

struct LayerContainer: View {
    @ObservedObject var router: AppRouter
    @Environment(\.modelContext) var modelContext

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch router.path {
                    case .home:
                        MainMenuView()
                    case .calendar:
                        CalendarView()
                    case .analytics:
                        AnalyticsView()
                }
                Rectangle()
                    .frame(height: 0.2)
                FooterView(router: router)
                    .padding(.vertical)
                    .padding(.horizontal, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(edges: [.bottom])
    }
}

#Preview {
    @Previewable @StateObject var router: AppRouter = .init()
    LayerContainer(router: router)
}
