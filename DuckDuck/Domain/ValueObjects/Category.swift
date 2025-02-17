enum Category: String, CaseIterable, Identifiable, Codable {
    case undefined = "undefined"
    case lifeStyle = "life_style"
    case health = "health"
    case entertainment = "entertainment"
    case business = "business"
    case education = "education"
    case digital = "digital"
    case other = "other"

    var id: Self { self }

    var localizedDescription: LocalizedDescription {
        let key = "category_\(self.rawValue)"
        return LocalizedDescription(key: key)
    }

    var imageName: String {
        switch self {
            case .undefined: return "folder"
            case .lifeStyle: return "house"
            case .health: return "figure.walk"
            case .entertainment: return "airpods.max"
            case .business: return "macbook.and.iphone"
            case .education: return "books.vertical"
            case .digital: return "wifi"
            case .other: return "cart"
        }
    }
}
