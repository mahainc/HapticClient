import Dependencies
import HapticClient

#if canImport(UIKit)
import UIKit
#endif

extension HapticClient: DependencyKey {
    public static let liveValue: HapticClient = {
        #if canImport(UIKit)
        return HapticClient(
            impact: { style in
                await MainActor.run {
                    let generator = UIImpactFeedbackGenerator(style: style.uiKit)
                    generator.prepare()
                    generator.impactOccurred()
                }
            },
            notification: { type in
                await MainActor.run {
                    let generator = UINotificationFeedbackGenerator()
                    generator.prepare()
                    generator.notificationOccurred(type.uiKit)
                }
            },
            selectionChanged: {
                await MainActor.run {
                    let generator = UISelectionFeedbackGenerator()
                    generator.prepare()
                    generator.selectionChanged()
                }
            }
        )
        #else
        return HapticClient.noop
        #endif
    }()
}

// MARK: - UIKit Conversions

#if canImport(UIKit)
extension HapticClient.ImpactStyle {
    var uiKit: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .light: .light
        case .medium: .medium
        case .heavy: .heavy
        case .soft: .soft
        case .rigid: .rigid
        }
    }
}

extension HapticClient.NotificationType {
    var uiKit: UINotificationFeedbackGenerator.FeedbackType {
        switch self {
        case .success: .success
        case .warning: .warning
        case .error: .error
        }
    }
}
#endif
