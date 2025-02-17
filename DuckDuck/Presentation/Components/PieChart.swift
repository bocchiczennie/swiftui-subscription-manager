import SwiftUI
import Charts

private struct Fruit {
    let name: String
    let count: Int
}

struct PieChart: View {
    @State private var fruits: [Fruit] = [
        .init(name: "りんご", count: 15),
        .init(name: "いちご", count: 12),
        .init(name: "さくらんぼ", count: 6),
        .init(name: "ぶどう", count: 5),
        .init(name: "バナナ", count: 4),
        .init(name: "オレンジ", count: 2)
    ]
    var isExpanded: Bool = true
    var body: some View {
        Chart(fruits, id: \.name) { fruit in
            SectorMark(
                angle: .value("count", fruit.count),
                innerRadius: .inset(isExpanded ? 60 : 50),
                angularInset: 3
            )
            .foregroundStyle(by: .value("name", fruit.name))
        }
        .chartLegend(position: .automatic, alignment: .bottom, spacing: 20)
    }
}

#Preview {
    let isExpanded: Bool = true
    PieChart(isExpanded: isExpanded)
}
