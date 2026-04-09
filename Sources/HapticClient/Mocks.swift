import Dependencies

extension HapticClient: TestDependencyKey {
    /// Test value — unimplemented, fails if called without explicit override.
    public static let testValue = HapticClient()

    /// Preview value — silent no-op, haptics don't fire in previews.
    public static let previewValue = HapticClient.noop
}

extension HapticClient {
    /// A no-op client that silently ignores all haptic requests.
    public static let noop = HapticClient(
        impact: { _ in },
        notification: { _ in },
        selectionChanged: {}
    )
}

extension DependencyValues {
    public var hapticClient: HapticClient {
        get { self[HapticClient.self] }
        set { self[HapticClient.self] = newValue }
    }
}
