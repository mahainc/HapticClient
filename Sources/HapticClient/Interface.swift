import Dependencies
import DependenciesMacros
import Foundation

/// A dependency client for triggering haptic feedback.
///
/// Usage in a reducer:
/// ```swift
/// @Dependency(\.hapticClient) var hapticClient
///
/// case .saveTapped:
///     return .run { [hapticClient] _ in
///         await hapticClient.impact(.medium)
///     }
/// ```
@DependencyClient
public struct HapticClient: Sendable {
    /// Trigger impact feedback with the specified style.
    public var impact: @Sendable (_ style: HapticClient.ImpactStyle) async -> Void = { _ in }

    /// Trigger notification feedback with the specified type.
    public var notification: @Sendable (_ type: HapticClient.NotificationType) async -> Void = { _ in }

    /// Trigger selection changed feedback.
    public var selectionChanged: @Sendable () async -> Void = {}
}
