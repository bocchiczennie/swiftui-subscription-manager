import SwiftUI
import SwiftData

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel: RegistrationViewModel = .init()
    var subscription: Subscription? = nil

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("register_view_title")
                    .font(.headline)
                    .bold()

                Button(action: {
                    if let subscription = subscription {
                        viewModel.send(intent: .performUpdate(subscription))
                    } else {
                        viewModel.send(intent: .performRegister)
                    }
                    dismiss()
                }, label: {
                    Text("save_title")
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(viewModel.isSaveButtonDisabled)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: nil)

            Rectangle().frame(height: 0.2).foregroundColor(.secondary)

            VStack {
                VStack(spacing: 0) {
                    TextField("register_service_title", text: Binding(
                        get: { viewModel.serviceName },
                        set: { viewModel.send(intent: .updateServiceName($0)) }
                    ))
                    .frame(height: 25)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()

                    Divider().padding(.leading)

                    TextField("cost_title", text: Binding(
                        get: { viewModel.amount },
                        set: { viewModel.send(intent: .updateAmount($0)) }
                    ))
                    .frame(height: 25)
                    .keyboardType(.numberPad)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()

                    Divider().padding(.leading)

                    HStack {
                        Text("category_title")
                            .foregroundColor(Color(uiColor: .placeholderText))
                        Spacer()
                        Picker("", selection: $viewModel.selectedSubscriptionCategory) {
                            ForEach(Category.allCases) { type in
                                HStack {
                                    Text(type.localizedDescription.description)
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: type.imageName)
                                }
                                .tag(type)
                            }
                        }
                        .frame(height: 25)
                        .tint(.gray)
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding()

                    Divider().padding(.leading)

                    HStack {
                        Text("renewal_interval_title")
                            .foregroundColor(Color(uiColor: .placeholderText))
                        Spacer()
                        Picker("", selection: $viewModel.selectedInterval) {
                            ForEach(Cycle.allCases) { type in
                                HStack {
                                    Text(type.localizedDescription.description)
                                }
                                .tag(type)
                            }
                        }
                        .frame(height: 25)
                        .tint(.gray)
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding()

                    Divider().padding(.leading)

                    HStack {
                        Text("renewal_date_title")
                            .foregroundColor(Color(uiColor: .placeholderText))
                        Spacer()

                        DatePicker(
                            "",
                            selection: Binding(
                                get: { viewModel.startDate },
                                set: { viewModel.send(intent: .updateStartDate($0)) }
                            ),
                            displayedComponents: .date
                        )
                        .tint(colorScheme == .dark ? .white : .black)
                        .buttonStyle(NoHighlightButtonStyle())
                    }
                    .padding()

                    Divider().padding(.leading)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: Binding(
                            get: { viewModel.memo },
                            set: { viewModel.send(intent: .updateMemo($0)) }
                        ))
                        .padding(.top, 8)
                        .padding(.leading, 12)
                        .frame(minHeight: 200)
                        .background(.clear)
                        if viewModel.memo.isEmpty {
                            Text("memo_title")
                                .padding()
                                .foregroundColor(Color(uiColor: .placeholderText))
                                .allowsHitTesting(false)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.setModelContext(modelContext)

            if let subscription = subscription {
                viewModel.setFormData(subscription)
            }
        }
    }
}

#Preview {
    RegistrationView()
}
