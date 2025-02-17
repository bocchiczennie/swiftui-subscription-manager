import SwiftUI

struct CalendarModal: View {
    @ObservedObject var viewModel: CalendarViewModel
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                if let subscriptions = viewModel.subscriptions {
                    VStack {
                        ForEach(subscriptions) { subscription in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(subscription.renewalDate.formatted(date: .abbreviated, time: .omitted))
                                        .font(.headline)
                                }
                                HStack {
                                    Image(systemName: subscription.category.imageName)
                                        .font(.title3)
                                        .padding()
                                        .frame(width: 60, height: 60)
                                        .background(.gray.opacity(0.4))
                                        .cornerRadius(10)
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(subscription.name)
                                            .bold()
                                    }
                                    Spacer()
                                    Text(subscription.price.amount, format: .currency(code: subscription.price.currency))
                                        .font(.footnote)
                                }
                                .padding(.top, 10)
                            }
                            .padding()
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                            .background(.quaternary)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
