import SwiftUI

struct CalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel: CalendarViewModel = .init()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let nextRenewalSubscription = viewModel.nextRenewalSubscription {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("next_renewal_date_title")
                                .font(.headline)
                            Text(nextRenewalSubscription.renewalDate.formatted(date: .abbreviated, time: .omitted))
                                .font(.headline)
                        }
                        HStack {
                            Image(systemName: nextRenewalSubscription.category.imageName)
                                .font(.title3)
                                .padding()
                                .frame(width: 60, height: 60)
                                .background(.gray.opacity(0.4))
                                .cornerRadius(10)
                            VStack(alignment: .leading, spacing: 10) {
                                Text(nextRenewalSubscription.name)
                                    .bold()
                            }
                            Spacer()
                            Text(nextRenewalSubscription.price.amount, format: .currency(code: nextRenewalSubscription.price.currency))
                                .font(.footnote)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .background(.quaternary)
                    .cornerRadius(10)
                }
                DatePicker(
                    "日付を選択",
                    selection: $viewModel.selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                .tint(colorScheme == .dark ? .white : .black)
                .background(.quaternary)
                .cornerRadius(10)
                .onChange(of: viewModel.selectedDate) {
                    viewModel.send(intent: .fetchSubscriptionsBySelectedDate)
                    viewModel.send(intent: .openModal)
                }
            }
            .padding()
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            .sheet(
                isPresented: $viewModel.isModalPresented,
                onDismiss: {
                    viewModel.send(intent: .closeModal)
                }) {
                    CalendarModal(viewModel: viewModel)
                        .presentationDetents([.height(200)])
                        .presentationDragIndicator(.visible)
                }
        }
        .onAppear {
            viewModel.setModelContext(modelContext)
            viewModel.onAppear()
        }
    }
}

#Preview {
    CalendarView()
}
