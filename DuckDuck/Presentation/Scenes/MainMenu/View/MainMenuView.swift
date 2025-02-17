import SwiftUI
import SwiftData

struct MainMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel: MainMenuViewModel = .init()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                ZStack {
                    Text("DuckDuck")
                        .font(.title2)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: nil)
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "creditcard")
                            Text("total_expenses_title")
                                .font(.title3)
                            Spacer()
                        }
                        HStack(alignment: .top, spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("annually_title")
                                ScrollView(.horizontal, showsIndicators: false) {
                                    Text(viewModel.annuallyAmount, format: .currency(code: Locale.current.currency?.identifier ?? "JPY"))
                                        .font(.title3)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("monthly_title")
                                ScrollView(.horizontal, showsIndicators: false) {
                                    Text(viewModel.monthlyAmount, format: .currency(code: Locale.current.currency?.identifier ?? "JPY"))
                                        .font(.title3)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("daily_title")
                                ScrollView(.horizontal, showsIndicators: false) {
                                    Text(viewModel.dailyAmount, format: .currency(code: Locale.current.currency?.identifier ?? "JPY"))
                                        .font(.title3)
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                .padding()

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.subscriptions) { subscription in

                            Button(action: {
                                viewModel.send(intent: .openDetail(subscription))
                            }, label: {
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
                                        HStack {
                                            Text("next_renewal_date_title")
                                                .font(.footnote)
                                            Text(subscription.renewalDate.formatted(date: .abbreviated, time: .omitted))
                                                .font(.footnote)
                                        }
                                    }
                                    Spacer()
                                    Text(subscription.price.amount, format: .currency(code: subscription.price.currency))
                                        .font(.footnote)
                                    Image(systemName: "chevron.right")
                                }
                            })
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100, alignment: .leading)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .safeAreaPadding()
                    .sheet(
                        isPresented: $viewModel.isRegistrationPresented,
                        onDismiss: {
                            viewModel.send(intent: .closeRegistration)
                            viewModel.onAppear()
                        },
                        content: {
                            RegistrationView()
                        })
                    .fullScreenCover(
                        item: $viewModel.selectedSubscription,
                        onDismiss: {
                            viewModel.send(intent: .closeDetail)
                            viewModel.onAppear()
                        },
                        content: { subscription in
                            DetailView(subscription: subscription)
                        })
                }
            }
            Button(action: {
                viewModel.send(intent: .openRegistration)
            }, label: {
                Image(systemName: "plus")
                    .padding(10)
                    .background(colorScheme == .dark ? .white : .black)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .bold()
                    .clipShape(Circle())
            })
            .padding()
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear {
            viewModel.setModelContext(modelContext)
            viewModel.onAppear()
        }
    }
}

#Preview {
    MainMenuView()
//        .preferredColorScheme(.dark)

}
