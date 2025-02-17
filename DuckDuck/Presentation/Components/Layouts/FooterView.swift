import SwiftUI

struct FooterView: View {
    @ObservedObject var router: AppRouter

    var body: some View {
        HStack {
            Button(action: {
                router.send(
                    intent: .switchingPages(.home)
                )
            }, label: {
                VStack(spacing: 5) {
                    Image(systemName: isCurrentPage(.home) ? "house.fill" : "house")
                        .font(.title3)
                        .frame(height: 25)
                    Text("footer_home_title")
                        .font(.caption)
                }
                .foregroundColor(.primary)
            })
            .buttonStyle(NoHighlightButtonStyle())

            Spacer()

            Button(action: {
                router.send(
                    intent: .switchingPages(.calendar)
                )
            }, label: {
                VStack(spacing: 5) {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .frame(height: 25)
                        .bold(isCurrentPage(.calendar))
                    Text("footer_calendar_title")
                        .font(.caption)
                }
                .foregroundColor(.primary)
            })
            .buttonStyle(NoHighlightButtonStyle())

            Spacer()

            Button(action: {
                router.send(
                    intent: .switchingPages(.analytics)
                )
            }, label: {
                VStack(spacing: 5) {
                    Image(systemName: isCurrentPage(.analytics) ? "chart.bar.fill" : "chart.bar")
                        .font(.title3)
                        .frame(height: 25)
                    Text("footer_analytics_title")
                        .font(.caption)
                }
                .foregroundColor(.primary)
            })
            .buttonStyle(NoHighlightButtonStyle())
        }
    }

    private func isCurrentPage(_ destination: Destination) -> Bool {
        return router.path == destination
    }
}

#Preview {
    @Previewable @StateObject var router: AppRouter = .init()
    FooterView(router: router)
}
