@MainActor
protocol IntentHandler {
    associatedtype I: Intent
    func send(intent: I)
}
