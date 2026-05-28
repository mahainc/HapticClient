# HapticClient

A small TCA dependency client for UIKit haptic feedback. Wraps `UIImpactFeedbackGenerator`, `UINotificationFeedbackGenerator`, and `UISelectionFeedbackGenerator` behind a `Sendable` interface that's safe to call from any actor context. Built on [`swift-composable-architecture`](https://github.com/pointfreeco/swift-composable-architecture).

The package ships two products:

- **`HapticClient`** — interface only. No UIKit import, safe for tests, previews, and non-iOS platforms.
- **`HapticClientLive`** — `#if canImport(UIKit)` wrapper around the three feedback generators, registered as the live `DependencyKey`. Falls back to `.noop` on platforms without UIKit.

## Installation

In your `Package.swift`:

```swift
.package(url: "https://github.com/mahainc/HapticClient.git", from: "0.1.0"),
```

Add `HapticClient` to your feature target and `HapticClientLive` to your app target.

## Usage

```swift
import HapticClient
import ComposableArchitecture

@Reducer
struct EditorFeature {
    @ObservableState
    struct State { /* ... */ }

    enum Action { case saveTapped, deleteTapped, selectionChanged }

    @Dependency(\.hapticClient) var hapticClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .saveTapped:
                return .run { _ in await hapticClient.notification(.success) }

            case .deleteTapped:
                return .run { _ in await hapticClient.impact(.heavy) }

            case .selectionChanged:
                return .run { _ in await hapticClient.selectionChanged() }
            }
        }
    }
}
```

## Feedback styles

```swift
// Impact — matches UIImpactFeedbackGenerator.FeedbackStyle
await hapticClient.impact(.light)    // .medium / .heavy / .soft / .rigid

// Notification — matches UINotificationFeedbackGenerator.FeedbackType
await hapticClient.notification(.success)   // .warning / .error

// Selection (pickers, segmented controls, etc.)
await hapticClient.selectionChanged()
```

## Testing

The interface module ships a `noop` factory for previews and `testValue` for `TestStore`:

```swift
let store = TestStore(initialState: EditorFeature.State()) {
    EditorFeature()
} withDependencies: {
    $0.hapticClient = .noop
}
```

`testValue` uses the macro-generated unimplemented defaults — override any closure individually to assert haptic invocation.

## Platform support

- iOS 17+ (full)
- macOS 14+ (falls back to `.noop` — no haptic hardware)

## License

MIT — see [LICENSE](./LICENSE).
