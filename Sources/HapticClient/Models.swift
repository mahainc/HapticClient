import Foundation

extension HapticClient {
    /// Impact feedback styles matching UIKit's UIImpactFeedbackGenerator.FeedbackStyle.
    public enum ImpactStyle: String, Sendable, Equatable, CaseIterable {
        case light
        case medium
        case heavy
        case soft
        case rigid
    }

    /// Notification feedback types matching UIKit's UINotificationFeedbackGenerator.FeedbackType.
    public enum NotificationType: String, Sendable, Equatable, CaseIterable {
        case success
        case warning
        case error
    }
}
