struct LocalizedDescription: Equatable, Hashable, CustomStringConvertible {
    private let key: String
    let localized: String

    init(key: String) {
        self.key = key
        self.localized = String(localized: String.LocalizationValue(key))
    }

    var description: String {
        return localized
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}
