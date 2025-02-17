import SwiftUI

struct DetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel: DetailViewModel = .init()
    var subscription: Subscription
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                })
                .foregroundColor(colorScheme == .dark ? .white : .primary)
            }
            .padding()
            ScrollView {
                VStack {
                    Text(viewModel.serviceName)
                        .font(.title3)
                        .fontWeight(.heavy)
                    HStack {
                        Text("next_renewal_date_title")
                            .fontWeight(.heavy)
                            .foregroundColor(.secondary)
                        Text(viewModel.renewalDate.formatted(date: .abbreviated, time: .omitted))
                            .fontWeight(.heavy)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical)

                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                            Text("renewal_interval_title")
                                .bold()
                            Spacer()
                            Text(viewModel.cycle.localizedDescription.description)
                        }
                        .padding(.horizontal, 30)
                        Divider().background(.secondary)
                        HStack {
                            let currencyIsKRW = viewModel.currency == "KRW"
                            // TODO: priceのcurrencyで条件分岐
                            Image(systemName: currencyIsKRW ? "wonsign.arrow.trianglehead.counterclockwise.rotate.90" : "yensign.arrow.trianglehead.counterclockwise.rotate.90")
                            Text("cost_title")
                                .bold()
                            Spacer()
                            Text(viewModel.amount, format: .currency(code: viewModel.currency))
                        }
                        .padding(.horizontal, 30)
                        Divider().background(.secondary)
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("next_renewal_date_title")
                                .bold()
                            Spacer()
                            Text(viewModel.renewalDate.formatted(date: .abbreviated, time: .omitted))
                        }
                        .padding(.horizontal, 30)
                        Divider().background(.secondary)
                        HStack {
                            Image(systemName: "folder")
                            Text("category_title")
                                .bold()
                            Spacer()
                            Text(viewModel.category.localizedDescription.description)
                        }
                        .padding(.horizontal, 30)
                        Divider().background(.secondary)
                        HStack {
                            Image(systemName: "pencil")
                            Text("memo_title")
                                .bold()
                            Spacer()
                            Text(viewModel.memo)
                        }
                        .padding(.horizontal, 30)
                        Divider().background(.secondary)
                    }
                    .padding(.top, 20)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            Spacer()
                            VStack(spacing: 10) {
                                Text("annually_title")
                                    .bold()
                                HStack(alignment: .firstTextBaseline) {
                                    Text(viewModel.annuallyAmount, format: .currency(code: subscription.price.currency))
                                }
                            }
                            .padding(.horizontal)

                            Divider().frame(maxWidth: 1, maxHeight: .infinity).background(.secondary)

                            VStack(spacing: 10) {
                                Text("monthly_title")
                                    .bold()
                                HStack(alignment: .firstTextBaseline) {
                                    Text(viewModel.monthlyAmount, format: .currency(code: subscription.price.currency))
                                }
                            }
                            .padding(.horizontal)

                            Divider().frame(maxWidth: 1, maxHeight: .infinity).background(.secondary)

                            VStack(spacing: 10) {
                                Text("daily_title")
                                    .bold()
                                HStack(alignment: .firstTextBaseline) {
                                    Text(viewModel.dailyAmount, format: .currency(code: subscription.price.currency))
                                }
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    HStack(spacing: 20) {
                        Spacer()
                        Button(action: {
                            viewModel.send(intent: .openRegistration)
                        }, label: {
                            HStack {
                                Image(systemName: "square.and.pencil")
                                Text("edit_title")
                                    .bold()
                            }
                        })
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                        .padding(10)
                        .background(.secondary)
                        .cornerRadius(10)

                        Button(action: {
                            viewModel.send(intent: .showAlert)
                        }, label: {
                            HStack {
                                Image(systemName: "trash")
                                Text("delete_title")
                                    .bold()
                            }
                        })
                        .foregroundColor(.red)
                        .padding(10)
                        .background(.secondary)
                        .cornerRadius(10)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(.ultraThinMaterial)
        .sheet(
            isPresented: $viewModel.isRegistrationPresented,
            onDismiss: {
                viewModel.send(intent: .closeRegistration)
                viewModel.reacquiringSubscription(subscription)
            },
            content: {
                RegistrationView(subscription: subscription)
            })
        .alert("subscription_delete_title", isPresented: $viewModel.showAlert) {
            Button("cancel_title", role: .cancel) {
                viewModel.send(intent: .hideAlert)
            }
            Button("delete_title", role: .destructive) {
                viewModel.send(intent: .performDelete(subscription))
                dismiss()
            }
        } message: {
            Text("subscription_delete_message")
        }
        .onAppear {
            viewModel.setModelContext(modelContext)
            viewModel.setField(subscription)
        }
    }
}
