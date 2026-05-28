import Testing
@testable import HapticClient

@Suite("HapticClient interface")
struct HapticClientTests {
    @Test("noop client never throws and never crashes")
    func noopAllPaths() async {
        let client = HapticClient.noop
        await client.impact(.medium)
        await client.notification(.success)
        await client.selectionChanged()
    }

    @Test("ImpactStyle round-trips through raw value")
    func impactStyleRawValues() {
        for style in HapticClient.ImpactStyle.allCases {
            #expect(HapticClient.ImpactStyle(rawValue: style.rawValue) == style)
        }
    }

    @Test("NotificationType round-trips through raw value")
    func notificationTypeRawValues() {
        for type in HapticClient.NotificationType.allCases {
            #expect(HapticClient.NotificationType(rawValue: type.rawValue) == type)
        }
    }
}
