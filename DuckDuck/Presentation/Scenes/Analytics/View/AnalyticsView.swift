import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(alignment: .leading) {
                        Text("total_amount_title")
                            .font(.title2)
                            .bold()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("annually_title")
                                    HStack(alignment: .firstTextBaseline) {
                                        Text("108,000")
                                            .font(.title2)
                                            .bold()
                                        Text("/")
                                            .font(.caption)
                                            .bold()
                                        Text("currency_title")
                                            .font(.caption)
                                            .bold()
                                    }
                                }
                                .padding()
                                .background(.quaternary)
                                .cornerRadius(10)
                                VStack(alignment: .leading) {
                                    Text("monthly_title")
                                    HStack(alignment: .firstTextBaseline) {
                                        Text("9,000")
                                            .font(.title2)
                                            .bold()
                                        Text("/")
                                            .font(.caption)
                                            .bold()
                                        Text("currency_title")
                                            .font(.caption)
                                            .bold()
                                    }
                                }
                                .padding()
                                .background(.quaternary)
                                .cornerRadius(10)
                                VStack(alignment: .leading) {
                                    Text("daily_title")
                                    HStack(alignment: .firstTextBaseline) {
                                        Text("600")
                                            .font(.title2)
                                            .bold()
                                        Text("/")
                                            .font(.caption)
                                            .bold()
                                        Text("currency_title")
                                            .font(.caption)
                                            .bold()
                                    }
                                }
                                .padding()
                                .background(.quaternary)
                                .cornerRadius(10)
                            }
                        }
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                    Rectangle().frame(height: 0.2).ignoresSafeArea(edges: [.trailing])

                    VStack(alignment: .leading) {
                        Text("graph_title")
                            .font(.title2)
                            .bold()
                        HStack {
                            VStack(alignment: .leading) {
                                PieChart(isExpanded: false)
                                    .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                            }
                            .padding()
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                        }
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: nil, alignment: .leading)

                    Rectangle().frame(height: 0.2).ignoresSafeArea(edges: [.trailing])

                    VStack(alignment: .leading) {
                        Text("total_items_title")
                            .font(.title2)
                            .bold()
                        HStack {
                            Text("total_subscriptions_description")
                                .bold()
                            Spacer()
                            HStack(alignment: .firstTextBaseline) {
                                Text("5")
                                    .font(.title2)
                                    .bold()
                                Text("unit_type_entry")
                                    .font(.caption)
                                    .bold()
                            }
                        }
                        .padding()
                        .background(.quaternary)
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: nil, alignment: .leading)

                    Rectangle().frame(height: 0.2).ignoresSafeArea(edges: [.trailing])

                    VStack(alignment: .leading) {
                        Text("number_of_registrations_by_category_title")
                            .font(.title2)
                            .bold()
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                            ForEach(Category.allCases) { type in
                                VStack(alignment: .leading) {
                                    Text(type.localizedDescription.description)
                                        .font(.footnote)
                                        .bold()
                                    HStack(alignment: .firstTextBaseline) {
                                        Text("0")
                                            .font(.title)
                                            .fontWeight(.medium)
                                            .bold()
                                        Text("unit_type_entry")
                                    }
                                    HStack {
                                        Spacer()
                                        Image(systemName: type.imageName)
                                            .font(.title2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                                .background(.quaternary)
                                .cornerRadius(10)
                                .tag(type)
                            }
                        }
                    }
                }
                .safeAreaPadding()
            }
            VStack {
                Text("Coming soon...")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .zIndex(1)
        }
    }
}

#Preview {
    AnalyticsView()
}
