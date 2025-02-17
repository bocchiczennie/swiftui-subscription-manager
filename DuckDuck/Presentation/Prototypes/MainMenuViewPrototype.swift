//import SwiftUI
//
//struct MainMenuViewPrototype: View {
//    @Environment(\.colorScheme) var colorScheme
//    private let navigationItems: [NavigationItemProtoType] = NavigationItemProtoType.samples
//    @State var selectedIndex: Int = 0
//    @State var indicatorOffset: CGFloat = 0
//    @State var isExpanded: Bool = false
//
//    var body: some View {
//        ZStack(alignment: .bottomTrailing) {
//            VStack(spacing: 0) {
//                ZStack {
//                    Text("DuckDuck")
//                        .font(.title2)
//                        .bold()
//                }
//                .padding()
//                .frame(maxWidth: .infinity, maxHeight: nil)
//                VStack(spacing: 20) {
//                    GeometryReader { geometry in
//                        VStack(spacing: 0) {
//                            HStack(spacing: 0) {
//                                ForEach(navigationItems.indices, id: \.self) { index in
//                                    let item = navigationItems[index]
//                                    Spacer()
//                                    Button(action: {
//                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()  // Haptic Touch
//                                        selectedIndex = index
//                                    }, label: {
//                                        VStack(spacing: 5) {
//                                            Image(systemName: item.imageName)
//                                                .font(.title3)
//                                                .foregroundColor(index == selectedIndex ? .primary : .secondary)
//                                            Text(item.title)
//                                                .font(.caption)
//                                                .foregroundColor(index == selectedIndex ? .primary : .secondary)
//                                        }
//                                    })
//                                    .buttonStyle(NoHighlightButtonStyle())
//                                    Spacer()
//                                }
//                            }
//                            .overlay(alignment: .bottomLeading) {
//                                Rectangle()
//                                    .frame(width: geometry.size.width / CGFloat(navigationItems.count), height: 2)
//                                    .offset(x: indicatorOffset, y: 5)
//                            }
//                            .onChange(of: selectedIndex) {
//                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()  // Haptic Touch
//                                withAnimation(.easeInOut(duration: 0.25)) {
//                                    indicatorOffset = geometry.size.width / CGFloat(navigationItems.count) * CGFloat(selectedIndex)
//                                }
//                            }
//                            Rectangle().frame(height: 0.2).offset(y: 5)
//                        }
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: 50)
//                }
//                TabView(selection: $selectedIndex) {
//                    ForEach(navigationItems.indices, id: \.self) { index in
//                        ScrollView {
//                            VStack(spacing: 10) {
//                                ForEach(0..<20) { _ in
//                                    Button(action: {
//
//                                    }, label: {
//                                        HStack {
//                                            Image(systemName: "airpods.max")
//                                                .font(.title3)
//                                                .padding()
//                                                .frame(width: 60, height: 60)
//                                                .background(.gray.opacity(0.4))
//                                                .cornerRadius(10)
//                                            VStack(alignment: .leading, spacing: 10) {
//                                                Text("Apple Music")
//                                                    .bold()
//                                                HStack {
//                                                    Text("renewal_date_title")
//                                                        .font(.footnote)
//                                                    Text(Date.now.formatted(date: .abbreviated, time: .omitted))
//                                                        .font(.footnote)
//                                                }
//
//                                            }
//                                            Spacer()
//                                            Text(1080, format: .currency(code: Locale.current.currency?.identifier ?? "JPY"))
//                                                .font(.footnote)
//                                            Image(systemName: "chevron.right")
//                                        }
//                                    })
//                                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100, alignment: .leading)
//                                    .buttonStyle(PlainButtonStyle())
//                                    .sheet(
//                                        isPresented: $isExpanded,
//                                        onDismiss: {
//                                            isExpanded = false
//                                        },
//                                        content: {
//                                            RegistrationView()
//                                        })
//                                }
//                            }
//                            .safeAreaPadding()
//                        }
//                        .tag(index)
//                    }
//                }
//                .tabViewStyle(.page(indexDisplayMode: .never))
//                .ignoresSafeArea()
//            }
//            Button(action: {
//                isExpanded = true
//            }, label: {
//                Image(systemName: "plus")
//                    .padding(10)
//                    .background(colorScheme == .dark ? .white : .black)
//                    .foregroundColor(colorScheme == .dark ? .black : .white)
//                    .bold()
//                    .clipShape(Circle())
//            })
//            .padding()
//            .buttonStyle(PlainButtonStyle())
//        }
//    }
//}
//
//private struct NavigationItemProtoType: Identifiable, CustomStringConvertible, Hashable {
//    let id: String
//    let title: String
//    let description: String
//    let imageName: String
//    let color: Color
//
//    static let samples: [NavigationItemProtoType] = [
//        .init(id: "1", title: "sample1", description: "This is a sample1", imageName: "house", color: .blue),
//        .init(id: "2", title: "sample2", description: "This is a sample1", imageName: "magnifyingglass", color: .blue)
//    ]
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//#Preview {
//    MainMenuViewPrototype()
//        .preferredColorScheme(.dark)
//
//}
