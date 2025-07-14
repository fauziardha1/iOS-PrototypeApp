import Foundation
import Combine

/// ViewModel for broadcasting notification banner messages reactively.
class NotificationBannerViewModel {
    // Published message string
    @Published var message: String? = nil
    
    // Singleton instance for global access
    static let shared = NotificationBannerViewModel()
    private init() {}
}
